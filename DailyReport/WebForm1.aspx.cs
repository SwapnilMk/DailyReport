using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

namespace webparts
{
    public partial class WebForm1 : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            welcomeWebPart.Text = TextBoxName.Text;
            if (IsPostBack == false)
            {
                foreach (WebPartDisplayMode mode in WebPartManager1.SupportedDisplayModes)
                {
                    DropDownList1.Items.Add(mode.Name);
                }

                DropDownList1.SelectedValue = "DesignDisplayMode";
            }
        }
        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

            if ((WebPartManager1.Personalization.Scope == PersonalizationScope.User)
      && (WebPartManager1.Personalization.CanEnterSharedScope))
            {
                WebPartManager1.Personalization.ToggleScope();
            }
            else if (WebPartManager1.Personalization.Scope ==
              PersonalizationScope.Shared)
            {
              //  WebPartManager1.Personalization.ToggleScope();
            }
            else
            {
                // If the user cannot enter shared scope you may want
                // to notify them on the page.
            }
        
            if (WebPartManager1.SupportedDisplayModes[DropDownList1.SelectedValue] != null)
            {
                //WebPartManager1.DisplayMode = WebPartManager1.SupportedDisplayModes
                //    [DropDownList1.SelectedValue];

                WebPartManager1.DisplayMode = WebPartManager.DesignDisplayMode;
            }
        }



    }
}