package package_25
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1945;
   
   [SecureSWF(rename="true")]
   public class class_1895
   {
      
      public static const const_560:int = 0;
      
      public static const const_191:int = 1;
      
      public static const const_695:int = 2;
      
      private var var_3861:String;
      
      private var _text:String;
      
      private var var_3934:int;
      
      private var var_4087:Boolean;
      
      private var var_2776:int;
      
      private var _guestRooms:Vector.<class_1945> = new Vector.<class_1945>(0);
      
      public function class_1895(param1:IMessageDataWrapper)
      {
         super();
         var_3861 = param1.readString();
         _text = param1.readString();
         var_3934 = param1.readInteger();
         var_4087 = param1.readBoolean();
         var_2776 = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            _guestRooms.push(new class_1945(param1));
            _loc3_++;
         }
      }
      
      public function get guestRooms() : Vector.<class_1945>
      {
         return _guestRooms;
      }
      
      public function get searchCode() : String
      {
         return var_3861;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get actionAllowed() : int
      {
         return var_3934;
      }
      
      public function get forceClosed() : Boolean
      {
         return var_4087;
      }
      
      public function get viewMode() : int
      {
         return var_2776;
      }
      
      public function set viewMode(param1:int) : void
      {
         var_2776 = param1;
      }
      
      public function findGuestRoom(param1:int) : class_1945
      {
         for each(var _loc2_ in _guestRooms)
         {
            if(_loc2_.flatId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

