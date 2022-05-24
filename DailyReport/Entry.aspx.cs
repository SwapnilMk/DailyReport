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
    public partial class Entry : System.Web.UI.Page
    {
        static string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {

                if (Session["Buissnesstype"].ToString() == "Water")
                {
                    divrate.Visible = true;
                }
                else
                {
                    divrate.Visible = false;
                }
                bindCusomers();
                bindArea();
            }
        }


        protected void btnsave_Click(object sender, EventArgs e)
        {

            string a = connStr;
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("InsertupdateCustomer", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@AreaId", ddlArea.SelectedValue);
            cmd.Parameters.Add("@Customerid", "0");
            cmd.Parameters.Add("@CustName", txtCustomername.Text);
            cmd.Parameters.Add("@Address", txtaddress.Text);

            cmd.Parameters.Add("@Mobile", txtContact.Text);
            cmd.Parameters.Add("@rate", txtrate.Text);

            cmd.Parameters.Add("@Status", "1");
            cmd.Parameters.AddWithValue("@Company", Convert.ToInt32(Session["company"]));


            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                bindCusomers();
                lblerror.Text = "Customer Added Successfully";
            }
            else
            {
                lblerror.Text = "Some Error Occured";

            }


        }

        public void bindCusomers()
        {
            clear();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("GetCustomer", conn);
            cmd.Parameters.AddWithValue("@Company", Convert.ToInt32(Session["company"]));
            cmd.CommandType = CommandType.StoredProcedure;
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                grdcustomer.DataSource = dt;
                grdcustomer.DataBind();
            }
        }

        public void bindArea()
        {
            try
            {
                clear();
                SqlConnection conn = new SqlConnection(connStr);
                SqlCommand cmd = new SqlCommand("GetArea", conn);
                cmd.Parameters.AddWithValue("@Company", Convert.ToInt32(Session["company"]));
                cmd.CommandType = CommandType.StoredProcedure;
                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    ddlArea.DataSource = dt;
                    ddlArea.DataValueField = "id";
                    ddlArea.DataTextField = "Area";
                    ddlArea.DataBind();
                }
            }
            catch (Exception ex)
            {
                lblerror.Text = ex.Message;
            }
        }

        public void clear()
        {
            txtaddress.Text = "";
            txtContact.Text = "";
            txtCustomername.Text = "";
            txtrate.Text = "";

        }

    }
}