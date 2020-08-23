<%-- 
    Document   : index
    Created on : 21 Aug, 2020, 5:02:08 PM
    Author     : ashut
--%>
<%@page import="org.hibernate.Session"%>
<%@page import="com.entities.Note"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="com.helper.FactoryProvider"%>
<%@page import="com.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">

    <title>Edit</title>
  </head>
  <body class="bg">
   
      <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script
            src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
        crossorigin="anonymous"></script>
      
      <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
 
    <div class="container">
        <%@include file="navbar.jsp" %> 
    </div>
  
    <%
  int noteId=Integer.parseInt(request.getParameter("note_id"));
            Session s=FactoryProvider.getFactory().openSession();
            Transaction tx=s.beginTransaction();
            Note note=s.get(Note.class, noteId);
       
  %>
  <div class="container">
      
   <form  id="updateNote" action="UpdateServlet" method="post">
  <div class="form-group">
      <input value="<%=note.getId()%>" name="noteId" type="hidden"/>
    <label for="title">Note Title</label>
    <input name="title" type="text" class="form-control" id="title" aria-describedby="emailHelp" required="true"
      value="<%=note.getTitle()%>"/>
   
  </div>
  <div class="form-group">
    <label for="content">Note Content</label>
   <textarea name="content" id="content" placeholder="Enter your content here.." class="form-control" style="height: 300px;"
      ><%=note.getContent()%></textarea>
  </div>
 
     
   <div class="container text-center mt-2">
       
       <button type="submit" class="btn " style="background-color: #673ab7;color: white" >Save note</button>
    </div>
  </form>
  </div>
  
  <script>
  
            
            
              $(document).ready(function (e) {



                $('#updateNote').submit(function (event) {
                    event.preventDefault(); // Prevent the form from submitting via the browser
                 //   console.log("clicked on submit");
                    let form = $(this);
                 //   console.log(form);
                 //   var form = new FormData(this);
                    $.ajax({
                        url: "UpdateServlet",
                        type: 'POST',
                        data: form.serialize(),
                        dataType: "text",
                                success: function (data, textStatus, jqXHR) {
                                 //   console.log(data);
                                    if (data.trim() == 'updated')
                                    {
                                           swal("Updated!",  "Redirecting you to show notes...","success");
                                           window.location="all_notes.jsp";
                                    } else
                                    {
                                        swal("Error!!", "Something went wrong try again...", "error");
                                    }


                                },

                        error: function (jqXHR, textStatus, errorThrown) {
                            //error..
                            swal("Error!!", "Something went wrong try again...", "error");
                        }


                    });
                });





            })
  </script>

  </body>
</html>