package package_111
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TradeNftAssetInventoryMessageEventParser implements IMessageParser
   {
      
      private var _items:Vector.<class_3106>;
      
      public function TradeNftAssetInventoryMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _items = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _items = new Vector.<class_3106>();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            _items.push(new class_3106(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get items() : Vector.<class_3106>
      {
         return _items;
      }
   }
}

