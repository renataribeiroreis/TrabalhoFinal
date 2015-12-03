# TrabalhoFinal------
Informações sobre o site
O site  simula o site de uma faculdade ficticia,onde o intuito é trabahar a disciplina aprendida e os tópicos estudados durante o semestre.
Teremos dois niveis de logins: usuário(acesso restrito)neste acesso o usuário terá apenas os seguintes acessos:
Contato.
Informações sobre o corpo docente.
Informações sobre o curso.

Já o admin(nivel com maior privilegios)terá os seguintes acessos:
Cadastro de Alunos.
Cadastro de Professores.
Edição do curriculo do corpo docente.
Edição e inclusão de cursos.

O site  foi desenvolvido em linguagem Haskell e para design utilizado o HTML e CSS.
Usuário administrador: admin
Senha:123456

Lista de Rotas:

/ 
tela inicial:
tela de apresentação da instituição e link de acessos para admin e usuários.

/admin
redireciona para /login


/login
Tela login:
Aqui o administrador faz login depois é redirecionado para /painel

/painel
Tela Bem-Vindo reservada para o administrador. No menu na parte superior o administrador pode cadastrar e listar: Usuários, alunos, diciplinas, cursos e professores. Pode voltar ao inicio ou sair do painel(log out).

/user
Tela de cadastro de usuários:
O administrador pode cadastrar usuário aqui.

/listarUser
Tela de Usuários cadastrados:
Aqui mostra uma lista de todos os usuário cadastrados e suas senhas.

/aluno
Cadastrar Alunos:
Nesta tela o admin cadastra alunos da instituição.

/listarAluno
Listar Alunos:
Nesta tela o admin visualiza todos alunos cadastrados da instituição.

/disciplina
Disciplinas:
O administrador cadastra disciplinas informando o nome, sigla, o curso e o professor que dará esta diciplina.

/listarDisciplina2
Tela de diciplinas cadastradas:
Aqui o administrador visualiza as diciplinas cadastradas e suas siglas.

/cursos
Tela Cadastrar Cursos:
Nesta tela o administrador cadastra os cursos  ministrados na faculdade.

/listarCursos2
Tela de Cursos cadastrados:
Nesta tela o administrador cadastra os cursos  ministrados na faculdade.

/professor
Cadastro de Professores:
Nesta tela poderá ser adicionado professores participantes do corpo docente e sua graduação.

/listarProfessor2
Listar Professores:
Nesta tela o admin visualiza todos professores cadastrados da instituição.

/bye
Tela de logout
 
Telas de usuário comum:

/page
Tela de apresentação da faculdade:
No menu na parte superior o usuário pode voltar a pagina inicial, ir para Home(/page), visualizar: informações sobre a faculdade(Quem somos), os cursos, as diciplinas, os professores e como entrar em contato com a facudade(Contato).

/historia
Tela Quem somos:
Tela  com informações da instituição.

/listarCursos
Tela Cursos:
Usuário apenas visualiza esta tela,onde está disponível todos os cursos oferecidos pela faculdade.

/listarDisciplina
Tela Disciplina:
Nesta tela é possível visualizar todas as disciplinas oferecidas pela faculdade.

/listarProfessor
Tela professores:
Nesta tela é possível visualizar todos os professores e suas respectivas graduações.

/contato
Tela contato:
Nesta tela fica visivel: telefone,endereço e email da faculdade.

 ----
 


