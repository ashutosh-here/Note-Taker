<%-- 
    Document   : index
    Created on : 21 Aug, 2020, 5:02:08 PM
    Author     : ashut
--%>

<%@page import="org.hibernate.query.Query"%>
<%@page import="javax.persistence.criteria.Root"%>
<%@page import="javax.persistence.criteria.CriteriaQuery"%>
<%@page import="javax.persistence.criteria.CriteriaBuilder"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="java.util.List"%>
<%@page import="com.entities.Note"%>

<%@page import="org.hibernate.Session"%>
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

    <title>Show Notes</title>
    
    
    
  </head>
  <body>
   <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
 
    <div class="container">
        <%@include file="navbar.jsp" %> 
   
        
        
        <div class="row mx-5">
            <div class="col-12">
                
                
                
                <% 
    
    Session s=FactoryProvider.getFactory().openSession();
 //  Query q= s.createQuery("from Note");
//    List<Note> list=q.list();

// Create CriteriaBuilder
CriteriaBuilder builder = s.getCriteriaBuilder();

// Create CriteriaQuery
CriteriaQuery<Note> crt = builder.createQuery(Note.class);
    
 Root<Note> root = crt.from(Note.class);
   // crt.select(root);
   crt.select(root).where(builder.isNotNull(root.get("content")));
   crt.orderBy(builder.desc(root.get("addedDate")));
    Query<Note> q = s.createQuery(crt);
   List<Note> list=q.getResultList();
 
    for(Note notes:list){
       // out.println(notes.getId()+":"+notes.getTitle()+":"+notes.getContent()+"<br>");
   

    %>
    
    <div class="card mt-5">
        <img src="notes.jpg" class="card-img-top m-2 p-2 mx-auto" alt="note image" style="max-width: 200px">
        
        <% SimpleDateFormat fmt=new SimpleDateFormat("E dd-MMM,yyyy");
        
          String date=fmt.format(notes.getAddedDate());
        
        %> 
        
        
  <div class="card-body px-5">
     
      <p><%=date%></p>
    <h5 class="card-title"><%=notes.getTitle()%></h5>
    <p class="card-text"><%=notes.getContent()%></p>
   
   <div class="container text-center  mt-2 ">
      
    <a href="edit.jsp?note_id=<%=notes.getId()%>" class="btn btn-primary">Update</a>
   
    
      <a href="DeleteServlet?note_id=<%=notes.getId()%>" class="btn btn-danger">Delete</a>
    
   
  </div>
</div>
    
    
    
    
    
    
    <%
    }
    s.close();
    
   %>
                
                
                
            </div>
        </div>  
        
        
        
    
    
    
        </div>
    
    
  
    </div>
  </body>
</html>