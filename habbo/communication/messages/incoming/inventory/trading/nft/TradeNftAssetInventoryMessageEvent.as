package package_179
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import package_111.TradeNftAssetInventoryMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class TradeNftAssetInventoryMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function TradeNftAssetInventoryMessageEvent(param1:Function)
      {
         super(param1,TradeNftAssetInventoryMessageEventParser);
      }
      
      public function getParser() : TradeNftAssetInventoryMessageEventParser
      {
         return var_15 as TradeNftAssetInventoryMessageEventParser;
      }
   }
}

