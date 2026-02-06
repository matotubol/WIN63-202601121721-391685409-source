package package_20
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RecyclerFinishedMessageEventParser implements IMessageParser
   {
      
      private var var_2682:int = -1;
      
      private var var_3208:int = 0;
      
      public function RecyclerFinishedMessageEventParser()
      {
         super();
      }
      
      public function get recyclerFinishedStatus() : int
      {
         return var_2682;
      }
      
      public function get prizeId() : int
      {
         return var_3208;
      }
      
      public function flush() : Boolean
      {
         var_2682 = -1;
         var_3208 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2682 = param1.readInteger();
         var_3208 = param1.readInteger();
         return true;
      }
   }
}

