package package_200
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class ModifyCustomFilterResultMessageEventParser implements IMessageParser
   {
      
      private var var_1122:int;
      
      private var var_4482:String;
      
      public function ModifyCustomFilterResultMessageEventParser()
      {
         super();
         var_1122 = -1;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1122 = param1.readInteger();
         var_4482 = param1.readString();
         return true;
      }
      
      public function get result() : int
      {
         return var_1122;
      }
      
      public function get word() : String
      {
         return var_4482;
      }
   }
}

