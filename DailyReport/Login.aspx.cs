using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
namespace DailyReport
{
    public partial class Login : System.Web.UI.Page
    {
      static  string connStr = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;

       
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        

        protected void btnlogin_Click(object sender, EventArgs e)
        {
            string a = connStr;
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("Validlogin", conn);
            cmd.Parameters.Add("@username", username.Value);
            cmd.Parameters.Add("@password", password.Value);

            cmd.CommandType = CommandType.StoredProcedure;
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                Session["company"] = dt.Rows[0]["Userid"];
                Session["Shopname"] = dt.Rows[0]["Company"];
                Session["UserName"] = username.Value;
                Session["UserId"] = dt.Rows[0]["Userid"];
                Session["Buissnesstype"] = dt.Rows[0]["Buissnesstype"];
                Response.Redirect("saloon.aspx");

            }
            else
            {
                lblerror.Text = "Invalid Credentials";

            }



        }
    }


}