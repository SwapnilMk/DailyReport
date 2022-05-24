using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.IO;

namespace DailyReport
{
    public partial class Saloon : System.Web.UI.Page
    {
        static string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        int id = 0;
         static int isincome = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //AutoCompleteExtender2.ContextKey = Session["company"].ToString();
                if (Session["grditem"] != null)
                {
                    Session["grditem"] = null;
                }
                
                string queryString = HttpContext.Current.Request.Url.ToString();
                var parsedString = HttpUtility.UrlDecode(queryString);
               string x=  getDecodedvalue(parsedString, "type");


                if (Request.QueryString["Type"] != null)
                {
                    isincome = 1;
                    lblcustomer.Text = "Seller Name";
                }
                else
                {
                    isincome = 0;
                }
                bindTransaction();
                bindItem();
            }
        }

        public string getDecodedvalue(string parsedString , string Queryparameter)
        {
            string QName = "";
            if (HttpContext.Current.Request.Url.Query != "")
            {
                 QName = HttpUtility.ParseQueryString(HttpUtility.UrlDecode(Request.RawUrl.ToString()).Split(new Char[] { '?' })[1])[Queryparameter];
            }
            return QName;
        }
        protected void btnsave_Click(object sender, EventArgs e)
        {


            string upDir = Path.Combine(Request.PhysicalApplicationPath, "images");
            // check if a file is being submitted  
            string sfn = "";
            if (fileup1.PostedFile.FileName != "")
            {
                // check extension  
                string ext = Path.GetExtension(fileup1.PostedFile.FileName);
                switch (ext.ToLower())
                {
                    case ".png":
                    case ".jpg":
                    case ".jpeg":
                    case ".gif":
                        break;
                    default:

                        lblerror.Text = "Unfortunately the selected file type is not currently supported, sorry...";
                        return;
                }
                // using the following 2 lines of code the file will retain its original name.  
                sfn = Path.GetFileName(fileup1.PostedFile.FileName);
                string fPath = Path.Combine(upDir, sfn);

                fileup1.PostedFile.SaveAs(fPath);
            }


                





                if (Session["grditem"] != null)
            {
                Session["grditem"] = null;
            }
            string a = connStr;
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("InsertupdatedOCHEADER", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@Date", DateTime.Now);
            cmd.Parameters.AddWithValue("@Customerid", 0);

            cmd.Parameters.AddWithValue("@Qty", 1);
            cmd.Parameters.AddWithValue("@rate", txtrate.Text);

            cmd.Parameters.AddWithValue("@Amount", txtAmount.Text);
            cmd.Parameters.AddWithValue("@EmptyBottles", 0);
            cmd.Parameters.AddWithValue("@Description", txtdesc.Text);
            cmd.Parameters.AddWithValue("@ItemId", ddlItem.SelectedValue);
            cmd.Parameters.AddWithValue("@companyid", Convert.ToInt32(Session["company"]));
            cmd.Parameters.AddWithValue("@CustName", txtcustomer.Text);
            cmd.Parameters.AddWithValue("@Isincome", isincome);
            cmd.Parameters.AddWithValue("@Attachment", "Images/" + sfn);
               

            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            conn.Close();
            if (dt.Rows.Count > 0)
            {
                clear();

                insertdocdetails(Convert.ToInt32(dt.Rows[0]["Sucess"]));
                bindTransaction();
                lblerror.Text = "Record Added  Successfully";
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
        public void bindTransaction()
        {

            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("GetTransaction", conn);
            cmd.Parameters.AddWithValue("@Company", Convert.ToInt32(Session["company"]));
            cmd.Parameters.AddWithValue("@Isincome", isincome);
            cmd.CommandType = CommandType.StoredProcedure;
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
               
                grdEntry.DataSource = dt;
                grdEntry.DataBind();
                //grdEntry.Columns[1].HeaderText = "Seller Name";
            }
            cmd.Dispose();

            clear();
        }
        protected void ddlItem_SelectedIndexChanged(object sender, EventArgs e)
        {
            bindRate();
        }

        public void clear()
        {
            txtdesc.Text = "";
            txtcustomer.Text = "";


            txtrate.Text = "";

            if (Session["grditem"] != null)
            {
                Session["grditem"] = null;
            }

            //grditem.DataSource = null;
            //grditem.DataBind();
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
                    txtAmount.Text = dt.Rows[0]["Rate"].ToString();
                    hdndisc.Value = dt.Rows[0]["Discount"].ToString();
                    txtDiscount.Text = dt.Rows[0]["Discount"].ToString();
                }
            }
            catch (Exception ex)
            {
                lblerror.Text = ex.Message;
            }
        }



        [WebMethod]
        public static List<string> SearchCustomers(string prefixText, int count)
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connStr;
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "select CustomerName from Customer where CustomerName like @SearchText + '%'";
                    cmd.Parameters.AddWithValue("@SearchText", prefixText);
                    cmd.Connection = conn;
                    conn.Open();
                    List<string> customers = new List<string>();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            customers.Add(sdr["CustomerName"].ToString());
                        }
                    }
                    conn.Close();

                    return customers;
                }
            }
        }


        protected void btnadditem_Click(object sender, EventArgs e)
        {
            try
            {
                lblerror.Text = "itemadded";
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
                    dtitem.Columns.Add("Discont", typeof(Int32));
                    dtitem.Columns.Add("Total", typeof(Int32));

                }
                else
                {
                    dtitem = Session["grditem"] as DataTable;
                }
                if (txtDiscount.Text == "")
                {
                    txtDiscount.Text = "0";
                }
                total = (Convert.ToInt32(txtrate.Text) * Convert.ToInt32(txtQty.Text)) - (Convert.ToInt32(txtDiscount.Text));
                dtitem.Rows.Add(id + 1, ddlItem.SelectedItem.Value, ddlItem.SelectedItem.Text, txtQty.Text, txtrate.Text, txtDiscount.Text, total);
                Session.Add("grditem", dtitem);

                grditem.DataSource = dtitem;
                grditem.DataBind();

                int finaltotal = dtitem.AsEnumerable().Sum(row => row.Field<int>("Total"));
                txtAmount.Text = finaltotal.ToString();
            }
            catch ( Exception ex)
            {
                lblerror.Text = ddlItem.SelectedItem.Value +"," + ddlItem.SelectedItem.Text + "," + txtQty.Text + "," + txtrate.Text + "," + txtDiscount.Text + Convert.ToString(0) +  ex.Message  ;
            }
        }

        protected void grditem_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            DataTable dtitem = new DataTable();
            string id = grditem.DataKeys[e.RowIndex].Value.ToString();
              dtitem = Session["grditem"] as DataTable;
            dtitem.Rows.RemoveAt(Convert.ToInt32(id));
            Session.Add("grditem", dtitem);

            grditem.DataSource = dtitem;
            grditem.DataBind();
            int finaltotal = dtitem.AsEnumerable().Sum(row => row.Field<int>("Total"));
            txtAmount.Text = finaltotal.ToString();

        }

      
    }
}