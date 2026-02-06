package package_25
{
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1945;
   
   [SecureSWF(rename="true")]
   public class class_1995
   {
      
      private var var_3088:String;
      
      private var var_3053:String;
      
      private var var_2963:class_1798;
      
      public function class_1995(param1:class_1798)
      {
         super();
         var_3088 = param1.searchCodeOriginal;
         var_3053 = param1.filteringData;
         var_2963 = param1;
      }
      
      public function get searchCodeOriginal() : String
      {
         return var_3088;
      }
      
      public function get filteringData() : String
      {
         return var_3053;
      }
      
      public function get resultSet() : class_1798
      {
         return var_2963;
      }
      
      public function findGuestRoom(param1:int) : class_1945
      {
         if(var_2963 != null)
         {
            return var_2963.findGuestRoom(param1);
         }
         return null;
      }
   }
}

