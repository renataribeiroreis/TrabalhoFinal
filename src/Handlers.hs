{-# LANGUAGE OverloadedStrings, QuasiQuotes,
             TemplateHaskell #-}
 
module Handlers where
import Import
import Yesod
import Yesod.Static
import Foundation
import Control.Monad.Logger (runStdoutLoggingT)
import Control.Applicative
import Data.Text
import Text.Lucius 

import Database.Persist.Postgresql

mkYesodDispatch "Sitio" pRoutes


widgetForm :: Route Sitio -> Enctype -> Widget -> Text -> Text -> Widget
widgetForm x enctype widget y val = do
     msg <- getMessage
     $(whamletFile "form.hamlet")
     toWidget $(luciusFile "teste.lucius")


-----[Login]--------------------------------------------
getLoginR :: Handler Html
getLoginR = do
    (wid,enc) <- generateFormPost formUsu
    defaultLayout $ widgetForm LoginR enc wid "" "Entrar" 

    
postLoginR :: Handler Html
postLoginR = do
    ((result,_),_) <- runFormPost formUsu
    case result of
        FormSuccess usr -> do
            usuario <- runDB $ selectFirst [UsuarioNome ==. usuarioNome usr, UsuarioPass ==. usuarioPass usr ] []
            case usuario of
                Just (Entity uid usr) -> do
                    setSession "_ID" (usuarioNome usr)
                    redirect PainelR
                Nothing -> do
                    setMessage $ [shamlet| Usuário não cadastrado |]
                    redirect LoginR 
        _ -> redirect LoginR

   
-----[Pagina Inicial]-----------------------------------
getInicioR :: Handler Html
getInicioR = defaultLayout [whamlet|

   <head>
    <link rel="icon" href=@{StaticR _Favicon_ico} type="image/x-icon"}>                
        
     
   <body bgcolor="#A9A9A9">
   <h1 align="center"> 
       <p>Seja Bem-Vindo a Faculdade de SpringField
          <p> Cursos Especializados para Personagens Ficticios em Geral<br><br>
                <img src=@{StaticR _SpringfieldElementary_jpg}><br>
                                                            
                <a href=@{PageR}"style= color:Crimson; text-decoration: none; text-decoration: none;"> << Acesso ao Site >> <br>                                                  
                <a href=@{LoginR}"style= color:Green; text-decoration: none; text-decoration: none;"> << Área Administrador >>   

|]
-----[Pagina Usuario]-----------------------------------
getPageR :: Handler Html
getPageR = defaultLayout [whamlet|

    <head>
       <link rel="icon" href=@{StaticR _Favicon_ico} type="image/x-icon"}>  
   
         
<div bgcolor="#A9A9A9">

     <div style="background-color:RebeccaPurple; padding: 10px;">
                 <a href="@{LoginR}" title="Administrativo" style="color:whitesmoke; text-decoration: none; text-align:left;"> | Área Administrativa | 
   
               <div style="background-color:RebeccaPurple; padding: 20px; text-align: right;">
                 <a href="@{InicioR}" title="Página Inicial" style="color:whitesmoke; text-decoration: none;"> Página Principal | 
                 <a href="@{PageR}" title="Home" style="color:whitesmoke; text-decoration: none;"> Home | 
                 <a href="@{HistoriaR}" title="História da faculdade" style="color:whitesmoke; text-decoration: none;">Quem somos  |
                 <a href="@{ListCursosR}" title="Curso Disponíveis" style="color:whitesmoke; text-decoration: none;"> Cursos |
                 <a href="@{ListDisciplinaR}" title="Disciplinas " style="color:whitesmoke; text-decoration: none;"> Disciplinas | 
                 <a href="@{ListProfessorR}" title="Professores" style="color:whitesmoke; text-decoration: none;"> Professores |  
                 <a href="@{ContatoR}" title="Contato" style="color:whitesmoke; text-decoration: none;">Contato | 
   <body bgcolor="#A9A9A9">
   <h1 align="center"> Faculdade de SpringField <br><br>
            <img src=@{StaticR _SpringfieldElementary_jpg}><br>
                   <center> <h4 style="color:SteelBlue";> A Magia do Saber, está nos Estudos que Devemos Aprender." <br> Tell Anderson

            
            
              
|]

-----[Historia]------------------------------------------------------------------
getHistoriaR :: Handler Html
getHistoriaR = defaultLayout [whamlet| 

      <head>
         <link rel="icon" href=@{StaticR _Favicon_ico} type="image/x-icon"}>  

<div bgcolor="#A9A9A9">

     <div style="background-color:RebeccaPurple; padding: 10px;">
                 <a href="@{LoginR}" title="Administrativo" style="color:whitesmoke; text-decoration: none; text-align:left;"> | Área Administrativa | 
   
               <div style="background-color:RebeccaPurple; padding: 20px; text-align: right;">
                 <a href="@{InicioR}" title="Página Inicial" style="color:whitesmoke; text-decoration: none;"> Página Principal | 
                 <a href="@{PageR}" title="Home" style="color:whitesmoke; text-decoration: none;"> Inicio | 
                 <a href="@{HistoriaR}" title="História da faculdade" style="color:whitesmoke; text-decoration: none;">Quem somos  |
                 <a href="@{ListCursosR}" title="Curso Disponíveis" style="color:whitesmoke; text-decoration: none;"> Cursos |
                 <a href="@{ListDisciplinaR}" title="Disciplinas " style="color:whitesmoke; text-decoration: none;"> Disciplinas | 
                 <a href="@{ListProfessorR}" title="Professores" style="color:whitesmoke; text-decoration: none;"> Professores |  
                 <a href="@{ContatoR}" title="Contato" style="color:whitesmoke; text-decoration: none;">Contato |
                   
    <body bgcolor="#f3f3f3">
               <div>
                    <h2 font style="color: MediumVioletRed; margin-left: 10px;">História da Faculdade de SpringField <br>
                      
                                                                                                 
             
                <div style="margin: 1cm 1cm 2cm 2cm; border-style: ridge; border-width: 5px;" "border-color: #FF00FF""margin-letf:5" >               
                                <h4 style="margin-left: 20px; margin-right:20px; color: #000080;" align="justify">Idealismo e entusiasmo foram alguns dos requisitos que levaram, em 1990, os 
                                   estudantes de Bartolomeu Simpson e Elizabet Simpson fundar a Faculdade para cursos de tecnologia, na cidade de Springfield.O sucesso alcançado 
                                   nos exames daquele ano pelos alunos por eles preparados fez com que, já em 1996, a Faculdade fosse um 
                                   dos maiores da cidade. A intenção sempre foi o desenvolvimento de um projeto educacional mais abrangente; por isso, a partir 
                                   do pequeno curso preparatório, a Faculdade de SpringField transformou-se em uma instituição diferenciada na cidade.
                 <br>
                     <div>
                     
                 <center> <img src=@{StaticR _Fundadores_jpg}><br>
                                                                             
 
|]
-----[Listar curso]----------------------------------------------
getListCursosR :: Handler Html
getListCursosR = do
             listaC <- runDB $ selectList [] [Asc CursosNome]
             defaultLayout [whamlet|
    <head>
        <link rel="icon" href=@{StaticR _Favicon_ico} type="image/x-icon"}>  
<div bgcolor="#A9A9A9">

     <div style="background-color:RebeccaPurple; padding: 10px;">
                 <a href="@{LoginR}" title="Administrativo" style="color:whitesmoke; text-decoration: none; text-align:left;"> | Área Administrativa | 
   
               <div style="background-color:RebeccaPurple; padding: 20px; text-align: right;">
                 <a href="@{InicioR}" title="Página Inicial" style="color:whitesmoke; text-decoration: none;"> Página Principal | 
                 <a href="@{PageR}" title="Home" style="color:whitesmoke; text-decoration: none;"> Inicio | 
                 <a href="@{HistoriaR}" title="História da faculdade" style="color:whitesmoke; text-decoration: none;">Quem somos  |
                 <a href="@{ListCursosR}" title="Curso Disponíveis" style="color:whitesmoke; text-decoration: none;"> Cursos |
                 <a href="@{ListDisciplinaR}" title="Disciplinas " style="color:whitesmoke; text-decoration: none;"> Disciplinas | 
                 <a href="@{ListProfessorR}" title="Professores" style="color:whitesmoke; text-decoration: none;"> Professores |  
                 <a href="@{ContatoR}" title="Contato" style="color:whitesmoke; text-decoration: none;">Contato | 
   <body bgcolor="#f3f3f3">
               <div>
                    <h2 font style="color:DarkBlue; margin-left: 10px;">Cursos Disponíveis <br>
                                                                                                 
             
                <div style="margin: 1cm 1cm 2cm 2cm; border-style:dashed; border-width: 3px;" "border-color: #FF4500""margin-letf:5" >               
                        
                             <ul font style="color #9932CC; size:3px"> Nome : Sigla <br>
                                   
                              $forall Entity pid cursos <- listaC
                                       <li style="color: DarkGreen;">#{cursosNome cursos} : <i>#{cursosSigla cursos} <br>
                     
|] 

-----[Listar disciplina]----------------------------------------------
getListDisciplinaR :: Handler Html
getListDisciplinaR = do
             listaD <- runDB $ selectList [] [Asc DisciplinaNome]
             defaultLayout [whamlet|

      <head>
         <link rel="icon" href=@{StaticR _Favicon_ico} type="image/x-icon"}>  
          
<div bgcolor="#A9A9A9">

     <div style="background-color:RebeccaPurple; padding: 10px;">
                 <a href="@{LoginR}" title="Administrativo" style="color:whitesmoke; text-decoration: none; text-align:left;"> | Área Administrativa | 
   
               <div style="background-color:RebeccaPurple; padding: 20px; text-align: right;">
                 <a href="@{InicioR}" title="Página Inicial" style="color:whitesmoke; text-decoration: none;"> Página Principal | 
                 <a href="@{PageR}" title="Home" style="color:whitesmoke; text-decoration: none;"> Inicio | 
                 <a href="@{HistoriaR}" title="História da faculdade" style="color:whitesmoke; text-decoration: none;">Quem somos  |
                 <a href="@{ListCursosR}" title="Curso Disponíveis" style="color:whitesmoke; text-decoration: none;"> Cursos |
                 <a href="@{ListDisciplinaR}" title="Disciplinas " style="color:whitesmoke; text-decoration: none;"> Disciplinas | 
                 <a href="@{ListProfessorR}" title="Professores" style="color:whitesmoke; text-decoration: none;"> Professores |  
                 <a href="@{ContatoR}" title="Contato" style="color:whitesmoke; text-decoration: none;">Contato | 
   <body bgcolor="#f3f3f3">
               <div>
                    <h2 font style="color:orangered; margin-left: 10px;">Disciplinas <br>
                                                                                                 
             
                <div style="margin: cm 1cm 2cm 2cm; border-style: groove; border-width: 5px;" "border-color: #FF7FF50" "margin-letf:8 border-radius: 5px;
" >               
                              
                         <ul style="color: #0000FF;  margin-left: 5px;font size:2" >Sigla : Nome 
                         $forall Entity pid disciplina <- listaD
                                <br>
                             <style="color: DarkGreen;  margin-left: 15px;"> #{disciplinaSigla disciplina} : <i>#{disciplinaNome disciplina}:
                                                                                
                      
|]



-----[Listar professor]----------------------------------------------
getListProfessorR :: Handler Html
getListProfessorR = do
             listaP <- runDB $ selectList [] [Asc ProfessorNome]
             defaultLayout [whamlet|
     <head>
         <link rel="icon" href=@{StaticR _Favicon_ico} type="image/x-icon"}>  
             
<div bgcolor="#A9A9A9">
     <div style="background-color:RebeccaPurple; padding: 10px;">
                 <a href="@{LoginR}" title="Administrativo" style="color:whitesmoke; text-decoration: none; text-align:left;"> | Área Administrativa | 
   
               <div style="background-color:RebeccaPurple; padding: 20px; text-align: right;">
                 <a href="@{InicioR}" title="Página Inicial" style="color:whitesmoke; text-decoration: none;"> Página Principal | 
                 <a href="@{PageR}" title="Home" style="color:whitesmoke; text-decoration: none;"> Inicio | 
                 <a href="@{HistoriaR}" title="História da faculdade" style="color:whitesmoke; text-decoration: none;">Quem somos  |
                 <a href="@{ListCursosR}" title="Curso Disponíveis" style="color:whitesmoke; text-decoration: none;"> Cursos |
                 <a href="@{ListDisciplinaR}" title="Disciplinas " style="color:whitesmoke; text-decoration: none;"> Disciplinas | 
                 <a href="@{ListProfessorR}" title="Professores" style="color:whitesmoke; text-decoration: none;"> Professores |  
                 <a href="@{ContatoR}" title="Contato" style="color:whitesmoke; text-decoration: none;">Contato | 
    <body bgcolor="#f3f3f3">
               <div>
                    <h2 font style="color: #FF00FF; margin-left: 10px;">Nossos Professores <br>
                                                                                                 
             
                <div style="margin: 1cm 1cm 2cm 2cm; border-style: double; border-width: 5px;" "border-color: #FF7FF50""margin-letf:5" >               
                

                        <ul style="color: #0000FF;">Nome : Graduação 
                                 
                         $forall Entity pid professor <- listaP
                               <li style="color:indigo;">#{professorNome professor} : <i>#{professorGraduacao professor} 
                              



|] 

-----[Contato]------------------------------------------------------------
getContatoR :: Handler Html
getContatoR = defaultLayout [whamlet| 

     <head>
         <link rel="icon" href=@{StaticR _Favicon_ico} type="image/x-icon"}>  
          
  <div bgcolor="#A9A9A9">

     <div style="background-color:RebeccaPurple; padding: 10px;">
                 <a href="@{LoginR}" title="Administrativo" style="color:whitesmoke; text-decoration: none; text-align:left;"> | Área Administrativa | 
   
               <div style="background-color:RebeccaPurple; padding: 20px; text-align: right;">
                 <a href="@{InicioR}" title="Página Inicial" style="color:whitesmoke; text-decoration: none;"> Página Principal | 
                 <a href="@{PageR}" title="Home" style="color:whitesmoke; text-decoration: none;"> Inicio | 
                 <a href="@{HistoriaR}" title="História da faculdade" style="color:whitesmoke; text-decoration: none;">Quem somos  |
                 <a href="@{ListCursosR}" title="Curso Disponíveis" style="color:whitesmoke; text-decoration: none;"> Cursos |
                 <a href="@{ListDisciplinaR}" title="Disciplinas " style="color:whitesmoke; text-decoration: none;"> Disciplinas | 
                 <a href="@{ListProfessorR}" title="Professores" style="color:whitesmoke; text-decoration: none;"> Professores |  
                 <a href="@{ContatoR}" title="Contato" style="color:whitesmoke; text-decoration: none;">Contato | 
   <body bgcolor="#f3f3f3">
               <div>
                    <h2 font style="color:Crimson; margin-left: 10px;">Contato <br>
             
                <div style="margin: 1cm 1cm 2cm 2cm; border-style: double; border-width: 5px;" "border-color: #FF7FF50""margin-letf:5" >               
                                <h4 style="margin-left: 20px; margin-right:20px; color: #0000FF;" align="justify">
                                    <center><img src=@{StaticR _Contato_jpg}><br>
                                    
                                    <ul>Endereço: 
                                        <li style="color: dimgray;">19 Plympton Street,SpringField

                                    <ul>Telefones: 
                                        <li style="color: dimgray;">(13) 8888-4321
                                            <li style="color: dimgray;">(13) 8888-1234

                                    <ul>E-mail: 
                                        <li style="color: dimgray;">faculdade_springfield@webmail.com

                                            
                                                  
                        

|]

-----[Área restrita]---------------------------------------------
getPainelR :: Handler Html
getPainelR = do
     usr <- lookupSession "_ID"
     defaultLayout [whamlet|

    <head>
       <link rel="icon" href=@{StaticR _Favicon_ico} type="image/x-icon"}>  
          
 <div bgcolor="#A9A9A9">
     <div style="background-color:Maroon; padding: 10px;">
                 <a href="@{PageR}" title="Site" style="color:whitesmoke; text-decoration: none; text-align:left;"> | Site | 

               <div style="background-color:Maroon; padding: 20px; text-align: right;">
                 <a href="@{InicioR}" title="Página Inicial " style="color:whitesmoke; text-decoration: none;"> Inicio | 
                 <a href="@{UsuarioR}" title="Cadastrar Novos Usuários " style="color:whitesmoke; text-decoration: none;"> Cadastro de Usuário |
                 <a href="@{ListUserR}" title="Usuários do Sistema" style="color:whitesmoke; text-decoration: none;"> Usuários Cadastrados |  
              
                 <a href="@{AlunoR}" title="Cadastrar Novos Alunos" style="color:whitesmoke; text-decoration: none;"> Cadastro de Aluno |
                 <a href="@{ListAlunoR}" title="Alunos" style="color:whitesmoke; text-decoration: none;"> Alunos Matriculados  |  
                 
                 <a href="@{DisciplinaR}" title="Cadastrar Disciplina" style="color:whitesmoke; text-decoration: none;"> Cadastro de Disciplina |  
                 <a href="@{ListDisciplina2R}" title="Listagem das disciplina" style="color:whitesmoke; text-decoration: none;"> Disciplinas Cadastradas|  

                <div style="background-color:Maroon; padding: 5px; text-align: right;">

                <a href="@{CursosR}" title="Cadastrar Curso" style="color:whitesmoke; text-decoration: none;"> Cadastro de Curso |  
                 <a href="@{ListCursos2R}" title="Listagem dos cursos" style="color:whitesmoke; text-decoration: none;"> Cursos Cadastrados|  
 
                 <a href="@{ProfessorR}" title="Cadastrar Professor" style="color:whitesmoke; text-decoration: none;"> Cadastro de Professor |
                 <a href="@{ListProfessor2R}" title="Listagem das professores" style="color:whitesmoke; text-decoration: none;"> Professores Cadastrados|  
              
                 <a href="@{ByeR}" title="Logout " style="color:whitesmoke; text-decoration: none;"> Sair do painel 

<div>
      <body bgcolor="#f3f3f3">
            <div>
                 <body >
        $maybe m <- usr
            
                    <div><div><br><br><br>
                    <h2 align="center"> Seja Bem-Vindo
                        <h1 align="center">Área Reservada do Sistema
                           <center> <img src=@{StaticR _Adm_jpg}><br>

                     
     
|]


-----[Listar usuário]----------------------------------------------
getListUserR :: Handler Html
getListUserR = do
             listaU <- runDB $ selectList [] [Asc UsuarioNome]
          
             defaultLayout [whamlet|

      <head>
          <link rel="icon" href=@{StaticR _Favicon_ico} type="image/x-icon"}>  
          <div bgcolor="#A9A9A9">
     <div style="background-color:Maroon; padding: 10px;">
                 <a href="@{PageR}" title="Site" style="color:whitesmoke; text-decoration: none; text-align:left;"> | Site | 

               <div style="background-color:Maroon; padding: 20px; text-align: right;">
                 <a href="@{InicioR}" title="Página Inicial " style="color:whitesmoke; text-decoration: none;"> Inicio | 
                 <a href="@{UsuarioR}" title="Cadastrar Novos Usuários " style="color:whitesmoke; text-decoration: none;"> Cadastro de Usuário |
                 <a href="@{ListUserR}" title="Usuários do Sistema" style="color:whitesmoke; text-decoration: none;"> Usuários Cadastrados |  
              
                 <a href="@{AlunoR}" title="Cadastrar Novos Alunos" style="color:whitesmoke; text-decoration: none;"> Cadastro de Aluno |
                 <a href="@{ListAlunoR}" title="Alunos" style="color:whitesmoke; text-decoration: none;"> Alunos Matriculados  |  
                 
                 <a href="@{DisciplinaR}" title="Cadastrar Disciplina" style="color:whitesmoke; text-decoration: none;"> Cadastro de Disciplina |  
                 <a href="@{ListDisciplina2R}" title="Listagem das disciplina" style="color:whitesmoke; text-decoration: none;"> Disciplinas Cadastradas|  

                <div style="background-color:Maroon; padding: 5px; text-align: right;">

                <a href="@{CursosR}" title="Cadastrar Curso" style="color:whitesmoke; text-decoration: none;"> Cadastro de Curso |  
                 <a href="@{ListCursos2R}" title="Listagem dos cursos" style="color:whitesmoke; text-decoration: none;"> Cursos Cadastrados|  
 
                 <a href="@{ProfessorR}" title="Cadastrar Professor" style="color:whitesmoke; text-decoration: none;"> Cadastro de Professor |
                 <a href="@{ListProfessor2R}" title="Listagem das professores" style="color:whitesmoke; text-decoration: none;"> Professores Cadastrados|  
              
                 <a href="@{ByeR}" title="Logout " style="color:whitesmoke; text-decoration: none;"> Sair do painel 

<div>
      <body bgcolor="#f3f3f3">
               <div>
                    <h2 font style="color: dimgray; margin-left: 10px;">Usuários Cadastrados<br>

                    <div style="margin: 1cm 1cm 2cm 2cm; border-style: double; border-width: 5px;" "border-color: #FF7FF50""margin-letf:5" >               
                
                        <ul style="color: #0000FF;">Nome : Senha 
                                 
                         $forall Entity pid usuario <- listaU
                               <li style="color: dimgray;">#{usuarioNome usuario} : #{usuarioPass usuario}
                |]



-----[Listar aluno]----------------------------------------------
getListAlunoR :: Handler Html
getListAlunoR = do
             listaA <- runDB $ selectList [] [Asc AlunoNome]
          
             defaultLayout [whamlet|

     <head>
        <link rel="icon" href=@{StaticR _Favicon_ico} type="image/x-icon"}>                
        <div bgcolor="#A9A9A9">
     <div style="background-color:Maroon; padding: 10px;">
                 <a href="@{PageR}" title="Site" style="color:whitesmoke; text-decoration: none; text-align:left;"> | Site | 

               <div style="background-color:Maroon; padding: 20px; text-align: right;">
                 <a href="@{InicioR}" title="Página Inicial " style="color:whitesmoke; text-decoration: none;"> Inicio | 
                 <a href="@{UsuarioR}" title="Cadastrar Novos Usuários " style="color:whitesmoke; text-decoration: none;"> Cadastro de Usuário |
                 <a href="@{ListUserR}" title="Usuários do Sistema" style="color:whitesmoke; text-decoration: none;"> Usuários Cadastrados |  
              
                 <a href="@{AlunoR}" title="Cadastrar Novos Alunos" style="color:whitesmoke; text-decoration: none;"> Cadastro de Aluno |
                 <a href="@{ListAlunoR}" title="Alunos" style="color:whitesmoke; text-decoration: none;"> Alunos Matriculados  |  
                 
                 <a href="@{DisciplinaR}" title="Cadastrar Disciplina" style="color:whitesmoke; text-decoration: none;"> Cadastro de Disciplina |  
                 <a href="@{ListDisciplina2R}" title="Listagem das disciplina" style="color:whitesmoke; text-decoration: none;"> Disciplinas Cadastradas|  

                <div style="background-color:Maroon; padding: 5px; text-align: right;">

                <a href="@{CursosR}" title="Cadastrar Curso" style="color:whitesmoke; text-decoration: none;"> Cadastro de Curso |  
                 <a href="@{ListCursos2R}" title="Listagem dos cursos" style="color:whitesmoke; text-decoration: none;"> Cursos Cadastrados|  
 
                 <a href="@{ProfessorR}" title="Cadastrar Professor" style="color:whitesmoke; text-decoration: none;"> Cadastro de Professor |
                 <a href="@{ListProfessor2R}" title="Listagem das professores" style="color:whitesmoke; text-decoration: none;"> Professores Cadastrados|  
              
                 <a href="@{ByeR}" title="Logout " style="color:whitesmoke; text-decoration: none;"> Sair do painel 

<div>
      <body bgcolor="#f3f3f3">
              
                    <h2 font style="color: dimgray; margin-left: 10px;">Alunos Cadastrados<br>

                    <div style="margin: 1cm 1cm 2cm 2cm; border-style: double; border-width: 5px;" "border-color: #FF7FF50""margin-letf:5" >               
                
                        <ul style="color: #0000FF;">Nome : Idade 
               
                         $forall Entity pid aluno <- listaA
                                 <li style="color: dimgray;">#{alunoNome aluno} : Idade: #{alunoIdade aluno} 

             |] 



--[DISCIPLINA]--

-----[Cadastro de Disciplina]----------------------------------------------
formDisciplina :: Form Disciplina  
formDisciplina = renderDivs $ Disciplina <$> 
             areq textField "Nome : " Nothing <*> 
             areq textField "Sigla:" Nothing <*>
             areq (selectField cursos) "Curso" Nothing <*>
             areq (selectField professor) "Professor" Nothing 

-- combobox:curso--
cursos = do
        entities <- runDB $ selectList [] [Asc CursosNome]
        optionsPairs $ Prelude.map (\en -> (cursosNome $ entityVal en, entityKey en)) entities  

-- combobox:professor--
professor = do
        entities <- runDB $ selectList [] [Asc ProfessorNome]
        optionsPairs $ Prelude.map (\en -> (professorNome $ entityVal en, entityKey en)) entities  

getDisciplinaR :: Handler Html
getDisciplinaR = do
    (wid,enc) <- generateFormPost formDisciplina
    defaultLayout $ widgetForm DisciplinaR enc wid "Cadastro de Disciplina" "Cadastrar"


-----[Resposta: Cadastro de Disciplina]---
postDisciplinaR :: Handler Html
postDisciplinaR = do
    ((result,_),_) <- runFormPost formDisciplina
    case result of
        FormSuccess usr -> do
            runDB $ insert usr
            setMessage $ [shamlet| <p> Disciplina inserida com sucesso! |]
            redirect DisciplinaR
        _ -> redirect DisciplinaR



-----[Listar disciplina]----------------------------------------------
getListDisciplina2R :: Handler Html
getListDisciplina2R = do
             listaD <- runDB $ selectList [] [Asc DisciplinaNome]
             defaultLayout [whamlet|


    <head>
        <link rel="icon" href=@{StaticR _Favicon_ico} type="image/x-icon"}>  
<div bgcolor="#A9A9A9">
     <div style="background-color:Maroon; padding: 10px;">
                 <a href="@{PageR}" title="Site" style="color:whitesmoke; text-decoration: none; text-align:left;"> | Site | 

               <div style="background-color:Maroon; padding: 20px; text-align: right;">
                 <a href="@{InicioR}" title="Página Inicial " style="color:whitesmoke; text-decoration: none;"> Inicio | 
                 <a href="@{UsuarioR}" title="Cadastrar Novos Usuários " style="color:whitesmoke; text-decoration: none;"> Cadastro de Usuário |
                 <a href="@{ListUserR}" title="Usuários do Sistema" style="color:whitesmoke; text-decoration: none;"> Usuários Cadastrados |  
              
                 <a href="@{AlunoR}" title="Cadastrar Novos Alunos" style="color:whitesmoke; text-decoration: none;"> Cadastro de Aluno |
                 <a href="@{ListAlunoR}" title="Alunos" style="color:whitesmoke; text-decoration: none;"> Alunos Matriculados  |  
                 
                 <a href="@{DisciplinaR}" title="Cadastrar Disciplina" style="color:whitesmoke; text-decoration: none;"> Cadastro de Disciplina |  
                 <a href="@{ListDisciplina2R}" title="Listagem das disciplina" style="color:whitesmoke; text-decoration: none;"> Disciplinas Cadastradas|  

                <div style="background-color:Maroon; padding: 5px; text-align: right;">

                <a href="@{CursosR}" title="Cadastrar Curso" style="color:whitesmoke; text-decoration: none;"> Cadastro de Curso |  
                 <a href="@{ListCursos2R}" title="Listagem dos cursos" style="color:whitesmoke; text-decoration: none;"> Cursos Cadastrados|  
 
                 <a href="@{ProfessorR}" title="Cadastrar Professor" style="color:whitesmoke; text-decoration: none;"> Cadastro de Professor |
                 <a href="@{ListProfessor2R}" title="Listagem das professores" style="color:whitesmoke; text-decoration: none;"> Professores Cadastrados|  
              
                 <a href="@{ByeR}" title="Logout " style="color:whitesmoke; text-decoration: none;"> Sair do painel 

<div>
      <body bgcolor="#f3f3f3">
               <div>
                    <h2 font style="color: dimgray; margin-left: 10px;">Disciplinas Cadastradas<br>
                                                                                                 
             
                <div style="margin: 1cm 1cm 2cm 2cm; border-style: double; border-width: 5px;" "border-color: #FF7FF50" "margin-letf:5" >               
                              
                         <ul style="color: #0000FF;  margin-left: 5px;">Sigla : Nome 
                         $forall Entity pid disciplina <- listaD
                             <li style="color: dimgray;  margin-left: 5px;">#{disciplinaSigla disciplina} : <i>#{disciplinaNome disciplina}
                      
|]



--[ALUNO]--

-----[Cadastro de Novo Aluno]----------------------------------------------
formAluno :: Form Aluno  
formAluno = renderDivs $ Aluno <$> 
             areq textField "Nome : " Nothing <*> 
             areq textField "Idade:" Nothing 
             
             

getAlunoR :: Handler Html
getAlunoR = do
    (wid,enc) <- generateFormPost formAluno
    defaultLayout $ widgetForm AlunoR enc wid "Cadastro de Aluno" "Cadastrar"


-----[Resposta: Cadastro de Aluno]---
postAlunoR :: Handler Html
postAlunoR = do
    ((result,_),_) <- runFormPost formAluno
    case result of
        FormSuccess usr -> do
            runDB $ insert usr
            setMessage $ [shamlet|  |]
            redirect ContatoAlunoR
        _ -> redirect ContatoAlunoR

--Contato Aluno

getContatoAlunoR :: Handler Html
getContatoAlunoR = defaultLayout [whamlet| 

<div bgcolor="#A9A9A9">
     <div style="background-color:Maroon; padding: 10px;">
                 <a href="@{PageR}" title="Site" style="color:whitesmoke; text-decoration: none; text-align:left;"> | Site | 

               <div style="background-color:Maroon; padding: 20px; text-align: right;">
                 <a href="@{InicioR}" title="Página Inicial " style="color:whitesmoke; text-decoration: none;"> Inicio | 
                 <a href="@{UsuarioR}" title="Cadastrar Novos Usuários " style="color:whitesmoke; text-decoration: none;"> Cadastro de Usuário |
                 <a href="@{ListUserR}" title="Usuários do Sistema" style="color:whitesmoke; text-decoration: none;"> Usuários Cadastrados |  
              
                 <a href="@{AlunoR}" title="Cadastrar Novos Alunos" style="color:whitesmoke; text-decoration: none;"> Cadastro de Aluno |
                 <a href="@{ListAlunoR}" title="Alunos" style="color:whitesmoke; text-decoration: none;"> Alunos Matriculados  |  
                 
                 <a href="@{DisciplinaR}" title="Cadastrar Disciplina" style="color:whitesmoke; text-decoration: none;"> Cadastro de Disciplina |  
                 <a href="@{ListDisciplina2R}" title="Listagem das disciplina" style="color:whitesmoke; text-decoration: none;"> Disciplinas Cadastradas|  

                <div style="background-color:Maroon; padding: 5px; text-align: right;">

                <a href="@{CursosR}" title="Cadastrar Curso" style="color:whitesmoke; text-decoration: none;"> Cadastro de Curso |  
                 <a href="@{ListCursos2R}" title="Listagem dos cursos" style="color:whitesmoke; text-decoration: none;"> Cursos Cadastrados|  
 
                 <a href="@{ProfessorR}" title="Cadastrar Professor" style="color:whitesmoke; text-decoration: none;"> Cadastro de Professor |
                 <a href="@{ListProfessor2R}" title="Listagem das professores" style="color:whitesmoke; text-decoration: none;"> Professores Cadastrados|  
              
                 <a href="@{ByeR}" title="Logout " style="color:whitesmoke; text-decoration: none;"> Sair do painel 

<div>
      <body bgcolor="#f3f3f3">

  
                    <h2 font style="color:Crimson; margin-left: 10px;">Contato <br> <p> Aluno inserido com sucesso!
             
                <div style="margin: 1cm 1cm 2cm 2cm; border-style: double; border-width: 5px;" "border-color: #FF7FF50""margin-letf:5" >               
                                <h4 style="margin-left: 20px; margin-right:20px; color: #0000FF;" align="justify">
                                    Em Breve o Responsável irá entrar em contato com o Aluno Cadastrado para informações sobre os cursos disponíveis com as informações solicitadas na secretaria da faculdade
                                            
                                                  
                        

|]


--[USUÁRIO]--

-----[Novo usuário]----------------------------------------------

formUsu :: Form Usuario
formUsu = renderDivs $ Usuario <$>
    areq textField "Nome do Usuario" Nothing <*>
    areq passwordField "Senha" Nothing

getUsuarioR :: Handler Html
getUsuarioR = do
    
    (wid,enc) <- generateFormPost formUsu
    defaultLayout $ widgetForm UsuarioR enc wid "Cadastro de Usuário" "Cadastrar"
    

-----[Resposta: Cadastro de Usuário]
postUsuarioR :: Handler Html
postUsuarioR = do
    ((result,_),_) <- runFormPost formUsu
    case result of
        FormSuccess usr -> do
            runDB $ insert usr
            setMessage $ [shamlet|

           
|] 
            
            redirect UsuarioR
        _ -> redirect UsuarioR
        



--[CURSO]--

-----[Cadastro de Novo Curso]----------------------------------------------
formCursos :: Form Cursos  
formCursos = renderDivs $ Cursos <$> 
             areq textField "Nome : " Nothing <*> 
             areq textField "Sigla:" Nothing 

getCursosR :: Handler Html
getCursosR = do
    (wid,enc) <- generateFormPost formCursos
    defaultLayout $ widgetForm CursosR enc wid "Cadastro de Curso" "Cadastrar"


-----[Resposta: Cadastro de Curso]---
postCursosR :: Handler Html
postCursosR = do
    ((result,_),_) <- runFormPost formCursos
    case result of
        FormSuccess usr -> do
            runDB $ insert usr
            setMessage $ [shamlet| <p> Curso inserido com sucesso! |]
            redirect CursosR
        _ -> redirect CursosR


-----[Listar curso]----------------------------------------------
getListCursos2R :: Handler Html
getListCursos2R = do
             listaC <- runDB $ selectList [] [Asc CursosNome]
             defaultLayout [whamlet|

    <head>
        <link rel="icon" href=@{StaticR _Favicon_ico} type="image/x-icon"}>  
 
<div bgcolor="#A9A9A9">
     <div style="background-color:Maroon; padding: 10px;">
                 <a href="@{PageR}" title="Site" style="color:whitesmoke; text-decoration: none; text-align:left;"> | Site | 

               <div style="background-color:Maroon; padding: 20px; text-align: right;">
                 <a href="@{InicioR}" title="Página Inicial " style="color:whitesmoke; text-decoration: none;"> Inicio | 
                 <a href="@{UsuarioR}" title="Cadastrar Novos Usuários " style="color:whitesmoke; text-decoration: none;"> Cadastro de Usuário |
                 <a href="@{ListUserR}" title="Usuários do Sistema" style="color:whitesmoke; text-decoration: none;"> Usuários Cadastrados |  
              
                 <a href="@{AlunoR}" title="Cadastrar Novos Alunos" style="color:whitesmoke; text-decoration: none;"> Cadastro de Aluno |
                 <a href="@{ListAlunoR}" title="Alunos" style="color:whitesmoke; text-decoration: none;"> Alunos Matriculados  |  
                 
                 <a href="@{DisciplinaR}" title="Cadastrar Disciplina" style="color:whitesmoke; text-decoration: none;"> Cadastro de Disciplina |  
                 <a href="@{ListDisciplina2R}" title="Listagem das disciplina" style="color:whitesmoke; text-decoration: none;"> Disciplinas Cadastradas|  

                <div style="background-color:Maroon; padding: 5px; text-align: right;">

                <a href="@{CursosR}" title="Cadastrar Curso" style="color:whitesmoke; text-decoration: none;"> Cadastro de Curso |  
                 <a href="@{ListCursos2R}" title="Listagem dos cursos" style="color:whitesmoke; text-decoration: none;"> Cursos Cadastrados|  
 
                 <a href="@{ProfessorR}" title="Cadastrar Professor" style="color:whitesmoke; text-decoration: none;"> Cadastro de Professor |
                 <a href="@{ListProfessor2R}" title="Listagem das professores" style="color:whitesmoke; text-decoration: none;"> Professores Cadastrados|  
              
                 <a href="@{ByeR}" title="Logout " style="color:whitesmoke; text-decoration: none;"> Sair do painel 

<div>
      <body bgcolor="#f3f3f3">
               <div>
                    <h2 font style="color: dimgray; margin-left: 10px;">Cursos Disponíveis <br>
                                                                                                 
             
                <div style="margin: 1cm 1cm 2cm 2cm; border-style: double; border-width: 5px;" "border-color: #FF7FF50""margin-letf:5" >               
                        
                             <ul style="color: #0000FF;">Nome : Sigla 
                                   
                              $forall Entity pid cursos <- listaC
                                       <li style="color: dimgray;">#{cursosNome cursos} : <i>#{cursosSigla cursos} <br>
                     
|] 


             

--[PROFESSOR]--

-----[Cadastro de Professor]----------------------------------------------
formProfessor :: Form Professor  
formProfessor = renderDivs $ Professor <$> 
             areq textField "Nome : " Nothing <*> 
             areq textField "Graduação:" Nothing 

getProfessorR :: Handler Html
getProfessorR = do
    (wid,enc) <- generateFormPost formProfessor
    defaultLayout $ widgetForm ProfessorR enc wid "Cadastro de Professor" "Cadastrar"


-----[Resposta: Cadastro de Professor]---
postProfessorR :: Handler Html
postProfessorR = do
    ((result,_),_) <- runFormPost formProfessor
    case result of
        FormSuccess usr -> do
            runDB $ insert usr
            setMessage $ [shamlet| <p> Professor inserido com sucesso! |]
            redirect ProfessorR
        _ -> redirect ProfessorR



-----[Listar professor]----------------------------------------------
getListProfessor2R :: Handler Html
getListProfessor2R = do
             listaP <- runDB $ selectList [] [Asc ProfessorNome]
             defaultLayout [whamlet|

   <head>
      <link rel="icon" href=@{StaticR _Favicon_ico} type="image/x-icon"}>  
          
 <div bgcolor="#A9A9A9">
     <div style="background-color:Maroon; padding: 10px;">
                 <a href="@{PageR}" title="Site" style="color:whitesmoke; text-decoration: none; text-align:left;"> | Site | 

               <div style="background-color:Maroon; padding: 20px; text-align: right;">
                 <a href="@{InicioR}" title="Página Inicial " style="color:whitesmoke; text-decoration: none;"> Inicio | 
                 <a href="@{UsuarioR}" title="Cadastrar Novos Usuários " style="color:whitesmoke; text-decoration: none;"> Cadastro de Usuário |
                 <a href="@{ListUserR}" title="Usuários do Sistema" style="color:whitesmoke; text-decoration: none;"> Usuários Cadastrados |  
              
                 <a href="@{AlunoR}" title="Cadastrar Novos Alunos" style="color:whitesmoke; text-decoration: none;"> Cadastro de Aluno |
                 <a href="@{ListAlunoR}" title="Alunos" style="color:whitesmoke; text-decoration: none;"> Alunos Matriculados  |  
                 
                 <a href="@{DisciplinaR}" title="Cadastrar Disciplina" style="color:whitesmoke; text-decoration: none;"> Cadastro de Disciplina |  
                 <a href="@{ListDisciplina2R}" title="Listagem das disciplina" style="color:whitesmoke; text-decoration: none;"> Disciplinas Cadastradas|  

                <div style="background-color:Maroon; padding: 5px; text-align: right;">

                <a href="@{CursosR}" title="Cadastrar Curso" style="color:whitesmoke; text-decoration: none;"> Cadastro de Curso |  
                 <a href="@{ListCursos2R}" title="Listagem dos cursos" style="color:whitesmoke; text-decoration: none;"> Cursos Cadastrados|  
 
                 <a href="@{ProfessorR}" title="Cadastrar Professor" style="color:whitesmoke; text-decoration: none;"> Cadastro de Professor |
                 <a href="@{ListProfessor2R}" title="Listagem das professores" style="color:whitesmoke; text-decoration: none;"> Professores Cadastrados|  
              
                 <a href="@{ByeR}" title="Logout " style="color:whitesmoke; text-decoration: none;"> Sair do painel 

<div>
      <body bgcolor="#f3f3f3">
               <div>
                    <h2 font style="color: dimgray; margin-left: 10px;">Professores Cadastrados<br>
                                                                                                 
             
                <div style="margin: 1cm 1cm 2cm 2cm; border-style: double; border-width: 5px;" "border-color: #FF7FF50""margin-letf:5" >               
                

                        <ul style="color: #0000FF;">Nome : Graduação 
                                 
                         $forall Entity pid professor <- listaP
                               <li style="color: dimgray;">#{professorNome professor} : <i>#{professorGraduacao professor}
                              



|] 




-----[Sair do painel]----------------------------------------------
getByeR :: Handler Html
getByeR = do
    deleteSession "_ID"
    defaultLayout [whamlet| 

   <body bgcolor="#A9A9A9">
   <h1 align="center"> Obrigado pela Visita!
            <br>
                <center> <img src=@{StaticR _Bye_jpg}><br>
            <a href=@{LoginR}"style= color:Crimson; text-decoration: none; text-decoration: none;">Acessar tela de Login

             <br>
               
            <a href=@{InicioR}"style= color:green; text-decoration: none; text-decoration: none;">Acessar a Página Principal
|]


----
getAdminR :: Handler Html
getAdminR = defaultLayout [whamlet|

    

|]


-----[Configuração do banco de dados]--------------------------------

connStr ="dbname=d6vagifnddd433 host=ec2-54-83-204-228.compute-1.amazonaws.com user=jwmugjwsneplki password=cVdYTsCwG-ygP4sWYtFt1lD2aA port=5432"
main::IO()
main = runStdoutLoggingT $ withPostgresqlPool connStr 10 $ \pool -> liftIO $ do 
       runSqlPersistMPool (runMigration migrateAll) pool
       s <- static "static"
       warpEnv (Sitio pool s)