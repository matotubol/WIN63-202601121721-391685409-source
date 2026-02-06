package package_189
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class SharedVariable
   {
      
      private var var_4246:WiredVariable;
      
      private var var_1951:int;
      
      private var _roomName:String;
      
      public function SharedVariable(param1:IMessageDataWrapper)
      {
         super();
         var_1951 = param1.readInteger();
         _roomName = param1.readString();
         var_4246 = new WiredVariable(param1);
      }
      
      public function get wiredVariable() : WiredVariable
      {
         return var_4246;
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
      
      public function get roomName() : String
      {
         return _roomName;
      }
   }
}

