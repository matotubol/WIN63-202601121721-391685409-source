package package_136
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TreasureHuntFirstWinnerMessageEventParser implements IMessageParser
   {
      
      private var var_3058:TreasureHuntWinnerInfo;
      
      public function TreasureHuntFirstWinnerMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_3058 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3058 = new TreasureHuntWinnerInfo(param1);
         return true;
      }
      
      public function get winnerInfo() : TreasureHuntWinnerInfo
      {
         return var_3058;
      }
   }
}

