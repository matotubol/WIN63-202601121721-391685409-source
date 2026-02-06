package package_20
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RecyclerStatusMessageEventParser implements IMessageParser
   {
      
      private var var_3295:int = -1;
      
      private var var_2906:int = 0;
      
      public function RecyclerStatusMessageEventParser()
      {
         super();
      }
      
      public function get recyclerStatus() : int
      {
         return var_3295;
      }
      
      public function get recyclerTimeoutSeconds() : int
      {
         return var_2906;
      }
      
      public function flush() : Boolean
      {
         var_3295 = -1;
         var_2906 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3295 = param1.readInteger();
         var_2906 = param1.readInteger();
         return true;
      }
   }
}

