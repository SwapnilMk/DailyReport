using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

namespace DailyReport
{
    public partial class Adminpanel : System.Web.UI.Page
    {
          static string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hdncompany.Value = Session["company"].ToString();
            }

        }

        protected void btnsearch_Click(object sender, EventArgs e)
        {
            try
            {

              

                using (SqlConnection conn = new SqlConnection())
                {
                    conn.ConnectionString = connStr;
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = txtQuery.Text;

                        cmd.Connection = conn;
                        conn.Open();

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        conn.Close();

                        grddata.DataSource = dt;
                        grddata.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                lblerror.Text = ex.Message;
            
            }
        }






        [WebMethod]
        public static string jqueryAjaxCall(string Type, string lastName, string companyname)
        {
            //Do coding staff.
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string commandtext = "";

                commandtext="GetCharts";
                using (SqlCommand cmd = new SqlCommand(commandtext, con))
                {
                    con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Type", Type);
                    cmd.Parameters.AddWithValue("@companyid", Convert.ToInt32(companyname));
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                    Dictionary<string, object> row;
                    foreach (DataRow dr in dt.Rows)
                    {
                        row = new Dictionary<string, object>();
                        foreach (DataColumn col in dt.Columns)
                        {
                            row.Add(col.ColumnName, dr[col]);
                        }
                        rows.Add(row);
                    }
                    return serializer.Serialize(rows);
                }
            }
        
          
        }

       
    



    }
}