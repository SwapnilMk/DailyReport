<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Bookmyorder.aspx.cs" Inherits="DailyReport.Bookmyorder" %>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!------ Include the above in your HEAD tag ---------->
<style>
    body{
    background: -webkit-linear-gradient(left, #0072ff, #00c6ff);
}
.contact-form{
    background: #fff;
    margin-top: 10%;
    margin-bottom: 5%;
    width: 70%;
}
.contact-form .form-control{
    border-radius:1rem;
}
.contact-image{
    text-align: center;
}
.contact-image img{
    border-radius: 6rem;
    width: 11%;
    margin-top: -3%;
    transform: rotate(29deg);
}
.contact-form form{
    padding: 14%;
}
.contact-form form .row{
    margin-bottom: -7%;
}
.contact-form h3{
    margin-bottom: 8%;
    margin-top: -10%;
    text-align: center;
    color: #0062cc;
}
.contact-form .btnContact {
    width: 50%;
    border: none;
    border-radius: 1rem;
    padding: 1.5%;
    background: #dc3545;
    font-weight: 600;
    color: #fff;
    cursor: pointer;
}
.btnContactSubmit
{
    width: 50%;
    border-radius: 1rem;
    padding: 1.5%;
    color: #fff;
    background-color: #0062cc;
    border: none;
    cursor: pointer;
}

</style>
<script>
    function validateitem() {
        if ($("[id*=grditem] td").closest("tr").length == 0) {
            alert("Please add item");
            return false;
        }

    }
    function Total() {


        if ($("#<%=txtQty.ClientID %>").val() == "")
        {
            alert("Please select Qty");
            return false;
        }
        else if ($("#<%=txtrate.ClientID %>").val() == "") {
            alert("Please select Rate");
            return false;
        }


    }
</script>
<div class="container contact-form">
            <div class="contact-image">
                <img src="https://image.ibb.co/kUagtU/rocket_contact.png" alt="rocket_contact"/>
            </div>
            <form id="formbybook" runat="server" method="post">
                <h3><span id="spncompany"> Place a Order </span> </h3> 
                <div align="right">
                 <a href="Images/Menucard.pdf" runat="server" id="linkmenu" download> Download Menu Card </a>
               </div>
                
               <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <input type="text" id="txtName" runat="server" class="form-control" placeholder="Your Name *" value="" />
                            
                        </div>
                        <div class="form-group">
                            <input type="text" name="txtEmail" class="form-control" placeholder="Your Email *" value="" />
                        </div>
                        <div class="form-group">
                            <input type="text" id="txtPhone" runat="server" class="form-control" placeholder="Your Phone Number *" value="" />
                        </div>
                         <div class="form-group">
                            <textarea name="txtMsg" class="form-control" placeholder="Your Message *" style="width: 100%; height: 150px;"></textarea>
                        </div>
                        
                    </div>
                    <div class="col-md-6">
                       
                         <div class="form-group">
                              <asp:DropDownList  CssClass="form-control" Width="300px"  AutoPostBack="true"  ID="ddlItem" runat="server">
                                <asp:ListItem>
                                    select item
                                </asp:ListItem>
                            </asp:DropDownList>
                             </div>
                        <div class="form-group ">
                             <asp:TextBox CssClass="form-control numberonly"  placeholder="Qty*"   ID="txtQty" runat="server"></asp:TextBox>
                        </div>
                          <div class="form-group">
                                       <asp:TextBox CssClass="form-control numberonly" placeholder="Rate*" ID="txtrate" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                                   <asp:Button ID="btnadditem" name="btnSubmit" cssclss="btn btn-primary" OnClick="btnadditem_Click" placeholder="Your Phone Number *" OnClientClick="return Total()" runat="server" text="Add item"/>
         
                        </div>
                        <div class="form-group">
                                    <asp:GridView CssClass="table table-responsive" ID="grditem" runat="server"></asp:GridView>
                        </div>
                         <div class="form-group">
                <asp:TextBox CssClass="form-control numberonly" ID="txtAmount" placeholder="Total*" enabled="false" runat="server"></asp:TextBox>
            </div>
                        
                          <div class="form-group">
                             
                             <asp:Label ID="lblerror" runat="server" ForeColor="Red"> </asp:Label>
                              </div>
                        <div class="form-group">
                              <asp:Button ID="btnsave" Width="200px"  CssClass=" btn btn-success" runat="server" Text="Save" OnClientClick="return validateitem()" OnClick="btnsave_Click" />
               
          
                        </div>
                    </div>

                </div>

                <br />
                <br />

                <br />

                <div  class="row" align:"center">
                    <div>
                        <h3>
                            Today's Offer  
                        </h3>
                    </div>
                    <div id="myCarousel" class="carousel slide" data-ride="carousel">
  <!-- Indicators -->
  <ol class="carousel-indicators">
    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
    <li data-target="#myCarousel" data-slide-to="1"></li>
    <li data-target="#myCarousel" data-slide-to="2"></li>
  </ol>

  <!-- Wrapper for slides -->
  <div class="carousel-inner">
    <div id="div1" class="item active">
      <img id="img1"  runat="server" src="Images/coco.png" height="150" alt="Los Angeles">
    </div>

    <div  id="div2" class="item">
      <img id="img2"  runat="server" src="Images/coco.png" height="150" alt="Chicago">
    </div>

    <div id="div3" class="item">
      <img id="img3" runat="server" src="Images/coco.png" height="150" alt="New York">
    </div>
  </div>

  <!-- Left and right controls -->
  <a class="left carousel-control" href="#myCarousel" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="right carousel-control" href="#myCarousel" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
                    </div>
                    </form>

</div>