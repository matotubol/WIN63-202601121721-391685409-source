package package_188
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class SharedGlobalPlaceholder
   {
      
      private var var_1951:int;
      
      private var _roomName:String;
      
      private var _placeholderName:String;
      
      public function SharedGlobalPlaceholder(param1:IMessageDataWrapper)
      {
         super();
         var_1951 = param1.readInteger();
         _roomName = param1.readString();
         _placeholderName = param1.readString();
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
      
      public function get roomName() : String
      {
         return _roomName;
      }
      
      public function get placeholderName() : String
      {
         return _placeholderName;
      }
   }
}

