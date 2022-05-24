using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace DailyReport
{
    public partial class Settings : System.Web.UI.Page
    {
        private string upDir;
        static string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        clsCommon objclscommon = new clsCommon();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                DataTable dt = objclscommon.getimages(Convert.ToInt32(Session["company"]));
                if (dt.Rows.Count > 0)
                {
                    img1.ImageUrl = dt.Rows[0]["Offerimage1"].ToString();
                    img2.ImageUrl = dt.Rows[0]["Offerimage2"].ToString();
                    img3.ImageUrl = dt.Rows[0]["Offerimage3"].ToString();
                }

                dt = objclscommon.getmenu(Convert.ToInt32(Session["company"]));
                if (dt.Rows.Count > 0)
                {

                }
            }

        }

        public List<FileInfo> GetImageNames()
        {
            string imgPath = Server.MapPath("~/images/");
            List<FileInfo> images = new List<FileInfo>();
            DirectoryInfo directoryInfo = new DirectoryInfo(imgPath);
            FileInfo[] fileInfo = directoryInfo.GetFiles();
            foreach (FileInfo file in fileInfo)
            {
                images.Add(file);
            }
            return images;
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            upDir = Path.Combine(Request.PhysicalApplicationPath, "images");
            // check if a file is being submitted  
            if (FileUpload1.PostedFile.FileName != "")
            {
                // check extension  
                string ext = Path.GetExtension(FileUpload1.PostedFile.FileName);
                switch (ext.ToLower())
                {
                    case ".png":
                    case ".jpg":
                    case ".jpeg":
                    case ".gif":
                        break;
                    default:
                        lblError.Text = "Unfortunately the selected file type is not currently supported, sorry...";
                        return;
                }
                // using the following 2 lines of code the file will retain its original name.  
                string sfn = Path.GetFileName(FileUpload1.PostedFile.FileName);
                string fPath = Path.Combine(upDir, sfn);

                try
                {
                    FileUpload1.PostedFile.SaveAs(fPath);
                    saveimage("Images/" + sfn);


                }
                catch (IOException ex)
                {
                    lblError.Text = "Error uploading file: " + ex.Message;
                }
                catch (Exception er)
                {
                    lblError.Text += "Unknown error: " + er.Message;
                }
            }
        }

        public void saveimage(string path)
        {
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("Insertupdateimages", conn);
            cmd.Parameters.AddWithValue("@userid", Convert.ToInt32(Session["company"]));
            cmd.Parameters.AddWithValue("@image", path);
            cmd.Parameters.AddWithValue("@type", Convert.ToInt32(ddlimg.SelectedValue));

            cmd.CommandType = CommandType.StoredProcedure;
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                img1.ImageUrl = dt.Rows[0]["Offerimage1"].ToString();
                img2.ImageUrl = dt.Rows[0]["Offerimage2"].ToString();
                img3.ImageUrl = dt.Rows[0]["Offerimage3"].ToString();
            }

        }

        protected void btnsave_Click(object sender, EventArgs e)
        {
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("UpdateSettings", conn);

            


            cmd.Parameters.AddWithValue("@userid", Convert.ToInt32(Session["company"]));
            cmd.Parameters.AddWithValue("@Area", chkmenu.Items[0].Selected);
            cmd.Parameters.AddWithValue("@item", chkmenu.Items[0].Selected);
            cmd.Parameters.AddWithValue("@Customer", chkmenu.Items[0].Selected);
            cmd.Parameters.AddWithValue("@Income", chkmenu.Items[0].Selected);
            cmd.Parameters.AddWithValue("@Expances", chkmenu.Items[0].Selected);
            cmd.Parameters.AddWithValue("@password",txtpassword.Text);

            
            cmd.CommandType = CommandType.StoredProcedure;
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {

            }
        }
    }
}