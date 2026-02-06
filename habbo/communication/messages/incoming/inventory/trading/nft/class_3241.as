package package_179
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import package_111.TradeNftAssetsMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class TradeNftAssetsMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function TradeNftAssetsMessageEvent(param1:Function)
      {
         super(param1,TradeNftAssetsMessageEventParser);
      }
      
      public function getParser() : TradeNftAssetsMessageEventParser
      {
         return var_15 as TradeNftAssetsMessageEventParser;
      }
   }
}

