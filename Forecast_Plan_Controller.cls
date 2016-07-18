public  class Forecast_Plan_Controller{

   


    public String YTD { get; set; }

    public double Revenue { get; set; }

    public String Q4TD { get; set; }

    public String Q3TD { get; set; }

    public String Q2TD { get; set; }

    public String Q1TD { get; set; }

    public String Q4 { get; set; }

    public String Q3 { get; set; }

    public String Q2 { get; set; }

    public double Q1 { get; set; }

    public Integer NoOfOpportunitiesQ4 { get; set; }

    public Integer  NoOfOpportunitiesQ3 { get; set; }

    public Integer  NoOfOpportunitiesQ2 { get; set; }

    public Integer NoOfOpportunitiesQ1 { get; set; }

    public double UsDollarRate { get; set; }

   
    public String Years { get; set; }
    
    public String SelectedAssignUser { get; set; }
    
    public list<SelectOption> cat{get;set;}
    
    public string SelectedvendorPlan{get;set;}
    
    public string Selectedcat{get;set;}
    
    public Plan__c plandata {get;set;}
    
    
     
      public Forecast_Plan_Controller(ApexPages.StandardController controller) {

    }

     
     
     public List<selectoption> getAssignUser() {
        List<selectOption> options1 = new List<selectOption>();
        options1.add(new selectOption('', '- None -')); 
        for (User users : [SELECT Id, LastName FROM User where IsActive =True]) { 
        system.debug('=====UserID======'+users.Id+'----Username--'+users.LastName );
            options1.add(new selectOption(users.Id, users.LastName )); 
        }
        return options1 ; 

    }

   public List<selectoption> getYear() {
        List<SelectOption> options2 = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = Plan__c.Year__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        options2.add(new Selectoption('None','--None--'));
        
            for( Schema.PicklistEntry f : ple)
            {
                 options2.add(new SelectOption(f.getLabel(), f.getValue()));
                 system.debug('-------------------label----------'+f.getLabel()+'-------value--------'+ f.getValue());
              
            }       
        return options2;
    }

   
   public List<selectoption> getvendor1(){
     
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = Products__c.Vendor__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
        options.add(new Selectoption('None','--None--'));
        
            for( Schema.PicklistEntry f : ple)
            {
                options.add(new SelectOption(f.getLabel(), f.getValue()));
                system.debug('-------------------label----------'+f.getLabel()+'-------value--------'+ f.getValue());
            } 
                  
        return options;
    }
    
    
   public List<selectoption> getc1(){
                
        set<String> cate1 = new set<String>();
        cat = new List<SelectOption>();       
        cat.add(new Selectoption('None','--None--'));
        
        system.debug('-------------------Selected vendore-----------------'+SelectedvendorPlan);
        List<Products__c> CatProd =  [Select Category_1__c From Products__c WHERE Vendor__c =: SelectedvendorPlan and Category_1__c != null ];
        
        for(Products__c pp : CatProd ){
        
            cate1.add(pp.Category_1__c);
            system.debug('CATEGORY'+pp.Category_1__c);
        } 
        
        for(string S:cate1 ){
             cat.add(new selectoption(s,s));
        }        
        
        return cat;
        
        }
        
        
         public PageReference ForecastCancel() {
        PageReference  pr =new PageReference ('https://entuple--ensandbox2.cs6.my.salesforce.com/a0Z/o');
        return pr;
    }


    public PageReference Forecastsave() {
    
    system.debug('-----vendore------'+SelectedvendorPlan);
            system.debug('-----Catogory------'+Selectedcat);
            system.debug('-----Revenue------'+Revenue);
            system.debug('-----Years ------'+Years);
            system.debug('-----Q1 ------'+Q1 );
            system.debug('-----Q2 ------'+Q2 );
            system.debug('-----Q3 ------'+Q3 );
            system.debug('-----Q4 ------'+Q4 );
            system.debug('-----UsDollarRate ------'+UsDollarRate );
            system.debug('-----SelectedAssignUser------'+SelectedAssignUser);
            
         
         
        
        
         if (SelectedvendorPlan =='None' )
        {
             ApexPages.Message myMsg = new ApexPages.message(ApexPages.severity.ERROR,'Please select Vendor');
             ApexPages.addMessage(myMsg);

            return null;
        } 
          
           if (Years =='None' )
        {
             ApexPages.Message myMsg = new ApexPages.message(ApexPages.severity.ERROR,'Please select Year');
             ApexPages.addMessage(myMsg);

            return null;
        } 
          
            if(Revenue ==0.0 )
        {
             ApexPages.Message myMsg = new ApexPages.message(ApexPages.severity.ERROR,'Please enter Revenue');
             ApexPages.addMessage(myMsg);

            return null;
        } 
         if (SelectedAssignUser == 'None' || SelectedAssignUser == null )
        {
             ApexPages.Message myMsg = new ApexPages.message(ApexPages.severity.ERROR,'Please select Assign To User');
             ApexPages.addMessage(myMsg);

            return null;
        }  
        
        
        
    
        Plan__c plandata =new  Plan__c ();   
        
    
        //plandata.US_Dollar_Rate__c = UsDollarRate ;
        plandata.Assign_To__c = SelectedAssignUser;
        plandata.Revenue__c = Revenue ;
        plandata.Year__c = Years ;
        plandata.No_Of_Opportunities__c = NoOfOpportunitiesQ1;
        plandata.No_Of_Opportunities_Q2__c = NoOfOpportunitiesQ2;
        plandata.No_Of_Opportunities_Q3__c = NoOfOpportunitiesQ3;
        plandata.No_Of_Opportunities_Q4__c = NoOfOpportunitiesQ4;
        plandata.Vendor__c = SelectedvendorPlan;
        plandata.category__c =Selectedcat;
       try{

         insert plandata;

         }

      catch(Exception ex){

          ApexPages.addMessages(ex);

       }

    
      
     PageReference  pr =new PageReference ('/'+plandata.id);
        return pr;
        return null;
    }
    

 }