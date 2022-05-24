using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls.WebParts;

namespace DailyReport
{
    public partial class LOGON : System.Web.UI.Page
    {
        static string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
           if (!IsPostBack)
            {
                //bindarea();
            }
        }

     

      

        protected void btnsave_Click(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SqlConnection conn = new SqlConnection(connStr);
            conn.Open();
            SqlCommand cmd = new SqlCommand("InsertupdateUser", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@username", txtusername.Value);
            cmd.Parameters.AddWithValue("@Email", txtemail.Value);
            cmd.Parameters.AddWithValue("@mobile", txtmobile.Value);
            cmd.Parameters.AddWithValue("@password", txtpassword.Value);
            cmd.Parameters.AddWithValue("@Company", texCompany.Value);
            cmd.Parameters.AddWithValue("@Address", txtAddress.Value);
            
            cmd.ExecuteNonQuery();
            lblerror.InnerText = "User Created Successfully.";
            Response.Redirect("login.aspx");
            conn.Close();
           // bindarea();

        }
    }
}