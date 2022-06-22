//A Boruto Company deseja realizar algumas automações nos processos de sua empresa. Antes de salvar um novo Lead, deve possuir pelo menos um dos números de contato (telefone ou celular) preenchido. Se o lead na hora de sua criação não possui uma classificação indicada por padrão deve ser atribuído Cold para o mesmo. A receita anual não pode ser nula, caso esteja vazia atribua o valor 0. Caso seja passado um valor negativo, emitir uma mensagem de erro. Quando um Lead é salvo e seu status é aberto e não contactado, deve ser criada uma tarefa associada ao lead, com o assunto ‘Entrar em contato nos próximos dias’. Um Lead não pode ser alterado do status aberto e não contactado para fechado e convertido ou fechado e não convertido, pois o Lead provavelmente não possui nenhuma interação com os vendedores.


trigger Lead on Lead(before insert, before update, after insert){
        string event = string.valueof(trigger.operationType);
       
    if(Trigger.isBefore && Trigger.isInsert){
        for(Lead Ld : Trigger.New){
            if(Ld.AnnualRevenue == null){
                Ld.AnnualRevenue = 0;
            }
            if(string.isBlank(Ld.Rating)){
                Ld.Rating = 'Cold';    
            }
            if(Ld.AnnualRevenue <0){
                Ld.AnnualRevenue.addError('O valor da Receita Anual não pode ser negativo');
            }
            if(string.isBlank(Ld.Phone) && string.isBlank(Ld.MobilePhone)){
                Ld.addError('Você deve preencher o campo de telefone ou celular');
            }           
        }
        
       
        if(Trigger.isBefore && Trigger.isUpdate){
            for(Lead Ld : Trigger.New){
                if(trigger.oldMap.get(Ld.id).status == 'Open - Not Contacted' && (Ld.Status == 'Closed - Converted' || Ld.Status == 'Closed - Not Converted')){
                   Ld.addError('Não é possível fazer essa alteração de Status');
                }
            }
        }
        if(Trigger.isAfter && Trigger.isInsert){
            List<Task> listTask = new List<Task>();
            
            for(Lead Ld : Trigger.New){  
                if(Ld.Status == 'Open - Not Contacted'){
                    Task t = new Task(
                    Subject = 'Entrar em contato nos próximos dias',
                    WhoId = Ld.Id
                    );
                listTask.add(t);
                }
             }
        }    
    }
}
