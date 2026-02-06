package package_165
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import package_136.TreasureHuntFailMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class TreasureHuntFailMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function TreasureHuntFailMessageEvent(param1:Function)
      {
         super(param1,TreasureHuntFailMessageEventParser);
      }
      
      public function getParser() : TreasureHuntFailMessageEventParser
      {
         return var_15 as TreasureHuntFailMessageEventParser;
      }
   }
}

