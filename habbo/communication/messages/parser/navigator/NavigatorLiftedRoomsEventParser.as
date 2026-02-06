package package_15
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import package_25.class_2999;
   
   [SecureSWF(rename="true")]
   public class NavigatorLiftedRoomsEventParser implements IMessageParser
   {
      
      private var _liftedRooms:Vector.<class_2999>;
      
      public function NavigatorLiftedRoomsEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _liftedRooms = new Vector.<class_2999>();
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _liftedRooms.push(new class_2999(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get liftedRooms() : Vector.<class_2999>
      {
         return _liftedRooms;
      }
   }
}

