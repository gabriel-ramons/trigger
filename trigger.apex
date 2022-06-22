//Q1 Realize uma trigger onde ao criar uma oportunidade caso o valor da oportunidade seja >= a 100000 e <= 200000, a fase deve ser colocada automaticamente para value proposition, senão a fase deve ficar em prospecting.

trigger Oportunidadetrigger on Opportunity (before update) {
          For(Opportunity OPP: Trigger.new){     
        IF(OPP.Amount >= 100000 && OPP.Amount <= 200000){
            OPP.StageName = 'Value proposition';
        }Else{
            OPP.StageName = 'Prospecting';
        }   
    }
}

//Q2 Realize uma trigger, que marque novas contas do setor de “Tecnologia” ou “Finanças” como “Hot” no sistema, ajudando assim sua empresa a priorizar essas vendas.

trigger AccountTrigger on Account (before insert, before update){
         for(Account Acc: Trigger.new)
        if(Acc.Industry =='Finance'|| Acc.Industry=='Technology'){
            Acc.Rating ='Hot';
          }
     }

//Q3 Preencha uma descrição do contato quando o usuário criar um contato.

trigger ctt on Contact (before insert) {
    for(Contact contato : trigger.new){
        if(trigger.isInsert){
            contato.Description = 'Contato criado com sucesso';
        }
    }
}

//Q4 Preencha a descrição do contato com o nome de usuário modificado quando o usuário atualizar o contato.

trigger ctt on Contact (before update) {
    for(contact ctt : trigger.new){
        
	ctt.Description = ' nome de usuário modificado ' +ctt.firstname;
}}

//Q5 Realize a inserção dos cenários dos exercícios 3 e 4  acima em um gatilho.

    trigger Contact on Contact (before insert, before update) {
    for(Contact ctt: Trigger.new)
  if(trigger.isInsert){
        ctt.description = 'contato inserido com sucesso';
        }
          if(trigger.isUpdate){
            ctt.Description = ' nome de usuário modificado ' +ctt.lastname;
        }
}
}

//Q6 Criar uma trigger em oportunidade para o caso o valor da oportunidade seja maior que 500000, automaticamente a fase passa para negotiation/review.

trigger Opportunity on Opportunity (before insert) {
    for (opportunity opp:trigger.new){
    if (opp.Amount > 500000){
    opp.StageName = 'negotiation/review';     
}  
}
}

//Q7 Ao inserir um lead, caso a origem do lead seja web, deve ser classificado como warm. caso seja other deve ser classificado como cold.

trigger Ld on Lead (before insert, before update) {
for(Lead ld: Trigger.new){
 	
    if(ld.LeadSource == 'Web'){
        ld.rating = 'Warm';
    }
    
    if(ld.leadSource == 'Other'){
        ld.rating = 'cold';
    }}}

//Q8 Antes de inserir uma nova conta, faça:
//- Não permitir que a receita anual seja nula ou negativa.
//- Se receita anual < 100000, salvar classificação como cold.
//- Se receita anual >= 100000 e < 500000, salvar classificação como warm.
//- Se receita anual >=500000, classificação hot.

   trigger Account  on Account (before insert, before update){
         for(Account Acc: Trigger.new)
         if(Acc.AnnualRevenue == null || acc.AnnualRevenue < 0.00){
           acc.Description.addError('Receita anual não pode ser nula ou negativa.');
        }   
         Else if (Acc.AnnualRevenue < 100000){
                Acc.Rating = 'Cold';
        }
         Else if (Acc.AnnualRevenue >=100000 && Acc.AnnualRevenue<500000){
                Acc.Rating = 'Warm';
        }
         Else if (Acc.AnnualRevenue >=500000){
               Acc.Rating = 'Hot';
        }
    }
