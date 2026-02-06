package package_165
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import package_136.TreasureHuntFirstWinnerMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class TreasureHuntFirstWinnerMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function TreasureHuntFirstWinnerMessageEvent(param1:Function)
      {
         super(param1,TreasureHuntFirstWinnerMessageEventParser);
      }
      
      public function getParser() : TreasureHuntFirstWinnerMessageEventParser
      {
         return var_15 as TreasureHuntFirstWinnerMessageEventParser;
      }
   }
}

