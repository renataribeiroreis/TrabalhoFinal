{-# LANGUAGE OverloadedStrings, TypeFamilies, QuasiQuotes,
             TemplateHaskell, GADTs, FlexibleContexts,
             MultiParamTypeClasses, DeriveDataTypeable,
             GeneralizedNewtypeDeriving, ViewPatterns #-}
module Foundation where
import Import
import Yesod
import Yesod.Static 
import Data.Text
import Database.Persist.Postgresql
    ( ConnectionPool, SqlBackend, runSqlPool, runMigration )

data Sitio = Sitio { connPool :: ConnectionPool,
                     getStatic :: Static }

staticFiles "static"

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|

Usuario
   nome Text
   pass Text
   deriving Show

Aluno
   nome Text
   idade Text
   deriving Show
   
Cursos
   nome Text
   sigla Text
   deriving Show
   
Professor
   nome Text
   graduacao Text
   deriving Show  

Disciplina
   nome Text
   sigla Text
   cursoid CursosId
   professorid ProfessorId
   deriving Show
 
|]

mkYesodData "Sitio" pRoutes

instance YesodPersist Sitio where
   type YesodPersistBackend Sitio = SqlBackend
   runDB f = do
       master <- getYesod
       let pool = connPool master
       runSqlPool f pool

instance Yesod Sitio where
    
    authRoute _ = Just $ LoginR
    isAuthorized LoginR _ = return Authorized
    isAuthorized AdminR _ = isAdmin
    isAuthorized PageR _ = isUser
    isAuthorized HistoriaR _ = isUser
    isAuthorized ByeR _ = isUser
    isAuthorized ContatoR _ = isUser
    isAuthorized DisciplinaR _ = isAdmin
    isAuthorized ListDisciplinaR _ = isUser
    isAuthorized AlunoR _ = isAdmin
    isAuthorized ListAlunoR _ = isAdmin
    isAuthorized CursosR _ = isAdmin
    isAuthorized ListCursosR _ = isUser
    isAuthorized ProfessorR _ = isAdmin
    isAuthorized UsuarioR _ = isAdmin
    isAuthorized ListUserR _ = isAdmin
    isAuthorized ListProfessorR _ = isUser
    isAuthorized _ _ = isUser


isAdmin = do
    mu <- lookupSession "_ID"
    return $ case mu of
        Nothing -> AuthenticationRequired
        Just "admin" -> Authorized
        Just _ -> Unauthorized "Soh o admin acessa aqui!"

isUser = do
    mu <- lookupSession "_ID"
    return $ case mu of
        Nothing -> Authorized
        --Nothing -> AuthenticationRequired
        Just _ -> Authorized

type Form a = Html -> MForm Handler (FormResult a, Widget)

instance RenderMessage Sitio FormMessage where
    renderMessage _ _ = defaultFormMessage


