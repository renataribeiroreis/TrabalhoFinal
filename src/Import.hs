{-# LANGUAGE TemplateHaskell, QuasiQuotes #-}
module Import where

import Yesod
import Yesod.Static 

pRoutes = [parseRoutes|
    / InicioR GET 
    /page PageR GET
    /painel PainelR GET
    /historia HistoriaR GET
    /static StaticR Static getStatic 
    /static1 Static1R Static getStatic 
    /static2 Static2R Static getStatic
    /static3 Static3R Static getStatic
    
    /login LoginR GET POST
    /bye ByeR GET
    /admin AdminR GET
    /contato ContatoR GET
    /contatoA ContatoAlunoR GET

    /disciplina DisciplinaR GET POST
    /listarDisciplina ListDisciplinaR GET
    /listarDisciplina2 ListDisciplina2R GET
  
    /aluno AlunoR GET POST
    /listarAluno ListAlunoR GET
  
    /cursos CursosR GET POST
    /listarCursos ListCursosR GET
    /listarCursos2 ListCursos2R GET
   
    /professor ProfessorR GET POST
    /listarProfessor ListProfessorR GET
    /listarProfessor2 ListProfessor2R GET
    
    /user UsuarioR GET POST
    /listarUser ListUserR GET
|]