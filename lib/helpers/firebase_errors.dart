String getErrorString(String code){
  if(code.contains("user-not-found")){
    return 'Não há usuário com este email.';
  }else if(code.contains("wrong-password")){
    return 'Senha inválida.';
  }else{
    return 'Erro Genérico: ' + code;
  }
}