<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="DailyReport.Login" %>

<!DOCTYPE html>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<style>
   
.gradient-custom-2 {
/* fallback for old browsers */
background: #fccb90;

/* Chrome 10-25, Safari 5.1-6 */
background: -webkit-linear-gradient(to right, #ee7724, #d8363a, #dd3675, #b44593);

/* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
background: linear-gradient(to right, #ee7724, #d8363a, #dd3675, #b44593);
}

@media (min-width: 768px) {
.gradient-form {
height: 10vh !important;
}
}
@media (min-width: 769px) {
.gradient-custom-2 {
border-top-right-radius: .3rem;
border-bottom-right-radius: .3rem;
}
}

</style>


<section class="h-100 gradient-form" style="background-color: #eee;">
  <div class="container py-5 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-xl-10">
        <div class="card rounded-3 text-black">
          <div class="row g-0">
            <div class="col-lg-6">
              <div class="card-body p-md-5 mx-md-4">

                <div class="text-center">
                  <%--<img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/lotus.webp"
                    style="width: 185px;" alt="logo">--%>
                    <img src="Images/logo.jpg"
                    style="width: 100px;height:100px " alt="logo">
                  <h4 class="mt-1 mb-5 pb-1">We are The My Buissness Team</h4>
                </div>

                <form id="loginform" class="form" runat="server">
                  <p>Please login to your account</p>

                  <div class="form-outline mb-4">
                    <input type="text"  id="username" class="form-control" runat="server"
                      placeholder="Phone number or email address" />
                    <label class="form-label" for="form2Example11">Username</label>
                  </div>

                  <div class="form-outline mb-4">
                    <input type="password" id="password" class="form-control" runat="server" />
                    <label class="form-label" for="form2Example22">Password</label>
                  </div>

                  <div class="text-center pt-1 mb-5 pb-1">
                  
                       <asp:Button ID="btnlogin" Text="Login" runat="server" CssClass="btn btn-primary btn-block fa-lg gradient-custom-2 mb-3" OnClick="btnlogin_Click" />
                               
                    <a class="text-muted" href="#!">Forgot password?</a>
                  </div>

                  <div class="d-flex align-items-center justify-content-center pb-4">
                    <p class="mb-0 me-2">Don't have an account?</p>
                  
                       <a href="logon.aspx" class="btn btn-outline-danger">Register here</a>
                  </div>
                    <asp:Label ID="lblerror" runat="server" ForeColor="Red"></asp:Label>
                </form>

              </div>
            </div>
            <div class="col-lg-6 d-flex align-items-center gradient-custom-2">
              <div class="text-white px-3 py-4 p-md-5 mx-md-4">
                <h4 class="mb-4">We are more than just a company</h4>
                <p class="small mb-0">We are helping you to manage your buissness perfectly,here you can track daily transaction,orders,bills,reports and many more for your buissness growth</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>



            
     
 