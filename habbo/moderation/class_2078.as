package com.sulake.habbo.moderation
{
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.utils.StringUtil;
   
   public class class_2078
   {
      
      private static var var_167:class_27;
      
      public function class_2078()
      {
         super();
      }
      
      public static function setLocalizationManager(param1:class_27) : void
      {
         var_167 = param1;
      }
      
      public static function getSourceName(param1:int) : String
      {
         switch(param1 - 1)
         {
            case 0:
            case 1:
               return "Normal";
            case 2:
               return "Automatic";
            case 3:
               return "Automatic IM";
            case 4:
               return "Guide System";
            case 5:
               return "IM";
            case 6:
               return "Room";
            case 7:
               return "Panic";
            case 8:
               return "Guardian";
            case 9:
               return "Automatic Helper";
            case 10:
               return "Discussion";
            case 11:
               return "Selfie";
            case 13:
               return "Photo";
            case 14:
               return "Ambassador";
            default:
               return "Unknown";
         }
      }
      
      public static function getCategoryName(param1:int) : String
      {
         if(var_167 != null)
         {
            var _loc2_:String = var_167.getLocalization("help.cfh.topic." + param1);
            if(!StringUtil.isEmpty(null))
            {
               return null;
            }
         }
         switch(param1)
         {
            case 0:
               return "Automatic";
            case 101:
               return "Sex";
            case 102:
               return "PII";
            case 103:
               return "Scam";
            case 104:
               return "Bullying";
            case 105:
               return "Disruption";
            case 106:
               return "Other";
            case 111:
               return "Sex";
            case 112:
               return "Scam";
            case 113:
               return "Disruption";
            case 114:
               return "Other";
            case 121:
               return "Sex";
            case 122:
               return "PII";
            case 123:
               return "Bullying";
            case 124:
               return "Other";
            case 130:
               return "Hate";
            case 131:
               return "Violence";
            case 132:
               return "Sex";
            case 133:
               return "Illegal";
            case 134:
               return "PII";
            case 135:
               return "Copyright";
            case 136:
               return "Spam";
            case 1024:
               return "Guide";
            case 1025:
               return "Bullying";
            case 1026:
               return "Severe Alert";
            default:
               return "Unknown";
         }
      }
   }
}

