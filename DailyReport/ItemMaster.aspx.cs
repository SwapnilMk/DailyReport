using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls.WebParts;
using DocumentFormat.OpenXml.Spreadsheet;
using ClosedXML.Excel;
using System.IO;

namespace DailyReport
{
    public partial class ItemMaster : System.Web.UI.Page
    {
        static string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
             bindarea();
            }
        }

        protected void btnsave_Click(object sender, EventArgs e)
        {

            SqlConnection conn = new SqlConnection(connStr);
            conn.Open();
            SqlCommand cmd = new SqlCommand("Insertupdateitem", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@ItemName", txtitem.Text);
            cmd.Parameters.Add("@Description", txtdesc.Text);
            cmd.Parameters.Add("@Rate", txtrate.Text);
            cmd.Parameters.Add("@Stock", txtstocck.Text);

            cmd.Parameters.Add("@Companyid", Session["company"].ToString());
            cmd.Parameters.Add("@id", hdnid.Value);
            cmd.Parameters.Add("@Discount", txtDiscount.Text);


            cmd.ExecuteNonQuery();
            if (Convert.ToInt32(hdnid.Value) == 0)
            {
                lblerror.Text = "Item Created Successfully.";
            }
            else
            {
                lblerror.Text = "Item Updated Successfully.";
            }
            hdnid.Value = "0";
            conn.Close();
            bindarea();
            clear();
        }

        public void clear()
        {
            txtdesc.Text = "";
            txtitem.Text = "";
            txtrate.Text = "";
            txtstocck.Text = "";
         }

        public void bindarea()
        {
            txtitem.Text = "";
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("getitem", conn);
            cmd.Parameters.AddWithValue("@Company", Convert.ToInt32(Session["company"]));
            cmd.CommandType = CommandType.StoredProcedure;
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                grdarea.DataSource = dt;
                grdarea.DataBind();
            }
            ViewState["dtitem"] = dt;
        }

        protected void grdarea_RowCommand(object sender, GridViewCommandEventArgs e)
        {
          
        }

        protected void grdarea_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow grow = grdarea.SelectedRow;
            int id = Convert.ToInt32( grow.Cells[0].Text);
            hdnid.Value = Convert.ToString( id);
            txtitem.Text = grow.Cells[1].Text;

            txtdesc.Text = grow.Cells[2].Text;
            txtrate.Text = grow.Cells[3].Text;

            txtstocck.Text = grow.Cells[4].Text;
            btnsave.Text = "Update";
        }

        protected void txtsearch_TextChanged(object sender, EventArgs e)
        {
            DataTable dt = (DataTable)ViewState["dtitem"];
            var results = from myRow in dt.AsEnumerable()
                          where myRow.Field<string>("itemname").ToUpper().StartsWith(txtsearch.Text.ToUpper())
                          select myRow;
            DataView view = results.AsDataView();
            dt = view.ToTable();


            if (dt.Rows.Count > 0)
            {
                grdarea.DataSource = dt;
                grdarea.DataBind();
                ViewState["dtitem"] = dt;
            }

        }

        public void Exporttoexcel(DataTable dt)
        {

            using (XLWorkbook wb = new XLWorkbook())
            {
                wb.Worksheets.Add(dt, "Customers");

                Response.Clear();
                Response.Buffer = true;
                Response.Charset = "";
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;filename=SqlExport.xlsx");
                using (MemoryStream MyMemoryStream = new MemoryStream())
                {
                    wb.SaveAs(MyMemoryStream);
                    MyMemoryStream.WriteTo(Response.OutputStream);
                    Response.Flush();
                    Response.End();
                }
            }


        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            DataTable dt = (DataTable)ViewState["dtitem"];
            Exporttoexcel(dt);

        }
    }
}
