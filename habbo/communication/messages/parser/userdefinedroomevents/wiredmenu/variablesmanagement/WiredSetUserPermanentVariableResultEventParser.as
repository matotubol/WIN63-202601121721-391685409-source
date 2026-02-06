package package_201
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class WiredSetUserPermanentVariableResultEventParser implements IMessageParser
   {
      
      private var var_2614:Boolean;
      
      public function WiredSetUserPermanentVariableResultEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2614 = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2614 = param1.readBoolean();
         return true;
      }
      
      public function get success() : Boolean
      {
         return var_2614;
      }
   }
}

