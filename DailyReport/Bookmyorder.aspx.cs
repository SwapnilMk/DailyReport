using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
namespace DailyReport
{
   
    public partial class Bookmyorder : System.Web.UI.Page
    {
        static string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        clsCommon objclscommon = new clsCommon();

        int id = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                int companyid = Convert.ToInt32( Request.QueryString["Compid"]);

                if (Session["grditem"] != null)
                {
                    Session["grditem"] = null;
                }
                Session["company"] = companyid;

                bindItem();
                DataTable dt = objclscommon.getimages(Convert.ToInt32(Session["company"]));
                if (dt.Rows.Count > 0)
                {
                    img1.Src = dt.Rows[0]["Offerimage1"].ToString();
                    img2.Src = dt.Rows[0]["Offerimage2"].ToString();
                    img3.Src = dt.Rows[0]["Offerimage3"].ToString();
                    linkmenu.HRef = dt.Rows[0]["menucard"].ToString();
                }
            }
        }

        public void bindItem()
        {
            try
            {

                SqlConnection conn = new SqlConnection(connStr);
                SqlCommand cmd = new SqlCommand("GetItemByCompany", conn);
                cmd.Parameters.AddWithValue("@companyid", Convert.ToInt32(Session["company"]));
                cmd.CommandType = CommandType.StoredProcedure;
                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {

                    ddlItem.DataSource = dt;
                    ddlItem.DataValueField = "id";
                    ddlItem.DataTextField = "ItemName";
                    ddlItem.DataBind();
                    bindRate();
                }
            }
            catch (Exception ex)
            {
                lblerror.Text = ex.Message;
            }
        }

        public void bindRate()
        {
            try
            {

                var myddlvalue = ddlItem.Items.FindByText(ddlItem.SelectedItem.Text).Value;
                SqlConnection conn = new SqlConnection(connStr);
                SqlCommand cmd = new SqlCommand("GetRateByItem", conn);
                cmd.Parameters.AddWithValue("@Itemid", Convert.ToInt32(ddlItem.SelectedValue));
                cmd.Parameters.AddWithValue("@companyid", Convert.ToInt32(Session["company"]));
                cmd.CommandType = CommandType.StoredProcedure;
                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {

                    txtrate.Text = dt.Rows[0]["Rate"].ToString();
                   // txtAmount.Text = dt.Rows[0]["Rate"].ToString();
                }
            }
            catch (Exception ex)
            {
                lblerror.Text = ex.Message;
            }
        }


        protected void btnsave_Click(object sender, EventArgs e)
        {





            if (Session["grditem"] != null)
            {
                Session["grditem"] = null;
            }
            string a = connStr;
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("InsertupdatedOCHEADER", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@Date", DateTime.Now);
            cmd.Parameters.AddWithValue("@Customerid", -1);

            cmd.Parameters.AddWithValue("@Qty", 1);
            cmd.Parameters.AddWithValue("@rate", txtrate.Text);

            cmd.Parameters.AddWithValue("@Amount", txtAmount.Text);
            cmd.Parameters.AddWithValue("@EmptyBottles", 0);
            cmd.Parameters.AddWithValue("@Description", "");
            cmd.Parameters.AddWithValue("@ItemId", ddlItem.SelectedValue);
            cmd.Parameters.AddWithValue("@companyid", Convert.ToInt32(Session["company"]));
            cmd.Parameters.AddWithValue("@CustName", txtName.Value +  " - " + txtPhone.Value);
            cmd.Parameters.AddWithValue("@Isincome", 0);
            cmd.Parameters.AddWithValue("@Attachment", "");


            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            conn.Close();
            if (dt.Rows.Count > 0)
            {
              

                insertdocdetails(Convert.ToInt32(dt.Rows[0]["Sucess"]));
                //bindTransaction();
                lblerror.Text = "Thank you for your order.";
            }
            else
            {
                lblerror.Text = "Some Error Occured";

            }


        }

        public void insertdocdetails(int docid)
        {


            for (int i = 0; i < grditem.Rows.Count; i++)
            {
                string a = connStr;
                SqlConnection conn = new SqlConnection(connStr);
                conn.Open();
                SqlCommand cmd = new SqlCommand("InsertupdateDocdetails", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Docid", docid);
                cmd.Parameters.AddWithValue("@ItemId", grditem.Rows[i].Cells[1].Text);

                cmd.Parameters.AddWithValue("@Qty", grditem.Rows[i].Cells[3].Text);
                cmd.Parameters.AddWithValue("@rate", grditem.Rows[i].Cells[4].Text);
                cmd.Parameters.AddWithValue("@ItemDesc", grditem.Rows[i].Cells[2].Text);
                cmd.Parameters.AddWithValue("@Discount", grditem.Rows[i].Cells[3].Text);


                cmd.ExecuteNonQuery();
                conn.Close();
            }




        }

        protected void btnadditem_Click(object sender, EventArgs e)
        {
            int total = 0;
            DataTable dtitem = new DataTable();
            if (Session["grditem"] == null)
            {
                DataTable Tissues = Session["grditem"] as DataTable;




                dtitem.Columns.Add("id", typeof(Int32));
                dtitem.Columns.Add("ItemId", typeof(Int32));
                dtitem.Columns.Add("ItemName", typeof(string));
                dtitem.Columns.Add("Qty", typeof(Int32));
                dtitem.Columns.Add("Rate", typeof(Int32));

                dtitem.Columns.Add("Total", typeof(Int32));

            }
            else
            {
                dtitem = Session["grditem"] as DataTable;
            }
            total = Convert.ToInt32(txtrate.Text) * Convert.ToInt32(txtQty.Text);
            dtitem.Rows.Add(id + 1, ddlItem.SelectedItem.Value, ddlItem.SelectedItem.Text, txtQty.Text, txtrate.Text, total);
            Session.Add("grditem", dtitem);

            grditem.DataSource = dtitem;
            grditem.DataBind();

            int finaltotal = dtitem.AsEnumerable().Sum(row => row.Field<int>("Total"));
           txtAmount.Text = finaltotal.ToString();
        }

    }


}