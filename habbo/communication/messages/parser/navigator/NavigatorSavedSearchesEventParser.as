package package_15
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import package_25.class_2073;
   
   [SecureSWF(rename="true")]
   public class NavigatorSavedSearchesEventParser implements IMessageParser
   {
      
      private var var_3080:Vector.<class_2073>;
      
      public function NavigatorSavedSearchesEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_3080 = new Vector.<class_2073>(0);
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            var_3080.push(new class_2073(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get savedSearches() : Vector.<class_2073>
      {
         return var_3080;
      }
   }
}

