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
    public partial class AreaMaster : System.Web.UI.Page
    {
        static string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                bindarea();
            }
        }

        protected void btnsave_Click(object sender, EventArgs e)
        {
          
            SqlConnection conn = new SqlConnection(connStr);
            conn.Open();
            SqlCommand cmd = new SqlCommand("InsertupdateArea", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@Area", txtarea.Text);
           cmd.Parameters.AddWithValue("@company", Convert.ToInt32(Session["company"]));

            cmd.ExecuteNonQuery();
            lblerror.Text = "Area Created Successfully.";
            conn.Close();
            bindarea();

        }


        public void bindarea()
        {
            txtarea.Text = "";
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("GetArea", conn);
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
        }
    }
}   