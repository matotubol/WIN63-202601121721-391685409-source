package package_20
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import package_48.PrizeLevelMessageData;
   
   [SecureSWF(rename="true")]
   public class RecyclerPrizesMessageEventParser implements IMessageParser
   {
      
      private var var_3522:Array;
      
      public function RecyclerPrizesMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = param1.readInteger();
         var_3522 = [];
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_3522.push(new PrizeLevelMessageData(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get prizeLevels() : Array
      {
         return var_3522;
      }
   }
}

