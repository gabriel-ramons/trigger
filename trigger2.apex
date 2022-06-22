//Q1 Antes de atualizar uma oportunidade, Se a fase anterior estiver fechada e perdida e tentarem alterar para qualquer outra nova fase. Emitir mensagem de erro.

        trigger OpportunityTrigger on Opportunity (before update) {
        for(Opportunity opp: Trigger.new){
              if(trigger.old[0].Stage Name == 'Closed Lost'){
                   opp.addError('Não é possível alterar a fase');
        }
     }
}

//Q2 Após a atualização de uma oportunidade, se o valor for maior ou igual a 50000 e a fase estiver fechada e ganha, crie uma tarefa associada a ela, com o assunto: Parabenizar a empresa pela nova aquisição.

trigger OpportunityTrigger on Opportunity ( after update) {
    for(Opportunity opp: Trigger.new){
      if(opp.Amount >= 50000 && opp.StageName == 'Closed Won'){
         Task newTask = new Task(
       Subject = 'Parabéns pela nova aquisição',
                WhoId = ldd.id
            );

}
}
}

//Q3 Após inserir um Lead, a receita anual estiver superior a 50000, criar uma tarefa com assunto verificar se o cadastro está completo associado ao lead.

trigger LeadLead on Lead (after insert){
    
    for(Lead ldd : trigger.new){
    if(ldd.AnnualRevenue >= 50000){
      Task newTask = new Task(
       Subject = 'Verificar se o Cadastro está completo',
                WhoId = ldd.id
            );
            
            insert newTask;
        }
    }
}
