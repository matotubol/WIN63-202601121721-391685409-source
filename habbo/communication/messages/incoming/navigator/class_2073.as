package package_25
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2073
   {
      
      private var var_197:int;
      
      private var var_3861:String;
      
      private var var_168:String;
      
      private var _localization:String;
      
      public function class_2073(param1:IMessageDataWrapper)
      {
         super();
         var_197 = param1.readInteger();
         var_3861 = param1.readString();
         var_168 = param1.readString();
         _localization = param1.readString();
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get searchCode() : String
      {
         return var_3861;
      }
      
      public function get filter() : String
      {
         return var_168;
      }
      
      public function get localization() : String
      {
         return _localization;
      }
   }
}

