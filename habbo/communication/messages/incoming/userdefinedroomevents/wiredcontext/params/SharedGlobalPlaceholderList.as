package package_188
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class SharedGlobalPlaceholderList
   {
      
      private var var_3633:Vector.<SharedGlobalPlaceholder>;
      
      public function SharedGlobalPlaceholderList(param1:IMessageDataWrapper)
      {
         super();
         var_3633 = new Vector.<SharedGlobalPlaceholder>();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_3633.push(new SharedGlobalPlaceholder(param1));
            _loc3_++;
         }
      }
      
      public function get sharedPlaceholders() : Vector.<SharedGlobalPlaceholder>
      {
         return var_3633;
      }
   }
}

