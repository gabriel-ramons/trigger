//Q1 Criar uma trigger para validar se das despesas não tem o valor acima de 700.

trigger desp on Despesa__c (before insert, before update) {
  for(Despesa__c desp : trigger.new){      
     IF(desp.Valor__c > 700){
     desp.Valor__c.adError('Despesa deve ter valor inferior à 700');
        }
    }       
}

//Q2 Criar uma trigger para validar se o campo telefone ou celular não são preenchidos em Lead.

trigger LeadLead on Lead (before insert, before update) {
    
     For(Lead itemLead : Trigger.new){
        If(String.isBlank(itemLead.Phone) || String.isBlank(itemLead.MobilePhone) ){
        itemLead.addError('Preencha os campos TELEFONE e Celular para concluir a criação de Lead');
     } 
   }           
}

//Q3 Criar uma trigger em Conta, caso o campo CNPJ não for preenchido.
//(Caso não tenha o campo CNPJ, deve-se realizar o processo padrão de criação do campo)

trigger AccountTrigger on Account (before insert) {
 for(Account acc : trigger.new){
  if(String.isblank(acc.CNPJ__c) && Trigger.isInsert){
   acc.CNPJ__c.addError('O campo de CNPJ deve ser preenchido');
}
}
}

//Q4 Criar uma trigger para dar 10% de desconto nas oportunidades para conta que tem o campo VIP verdadeiro

trigger OpportunityTrigger on Opportunity (before insert, before upDate) {
	 
	      for(Opportunity opp : Trigger.new){
	        if(opp.Account.VIP__c == false){
	            opp.Amount = opp.amount * 0.9;
	           
	        }
	    	}
}

