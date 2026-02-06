package package_165
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import package_136.TreasureHuntUpdateMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class TreasureHuntUpdateMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function TreasureHuntUpdateMessageEvent(param1:Function)
      {
         super(param1,TreasureHuntUpdateMessageEventParser);
      }
      
      public function getParser() : TreasureHuntUpdateMessageEventParser
      {
         return var_15 as TreasureHuntUpdateMessageEventParser;
      }
   }
}

