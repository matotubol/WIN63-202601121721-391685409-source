package com.sulake.habbo.communication.messages.incoming.handshake
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import com.sulake.habbo.communication.messages.parser.handshake.DisconnectReasonEventParser;
   
   [SecureSWF(rename="true")]
   public class DisconnectReasonEvent extends MessageEvent implements IMessageEvent
   {
      
      public static const const_170:int = -1;
      
      public static const const_1248:int = -2;
      
      public static const const_848:int = -3;
      
      public static const const_102:int = 0;
      
      public static const const_833:int = 1;
      
      public static const const_1006:int = 2;
      
      public static const const_625:int = 3;
      
      public static const const_393:int = 4;
      
      public static const const_132:int = 5;
      
      public static const const_886:int = 10;
      
      public static const const_703:int = 11;
      
      public static const const_837:int = 12;
      
      public static const const_185:int = 13;
      
      public static const const_845:int = 16;
      
      public static const const_1039:int = 17;
      
      public static const const_1059:int = 18;
      
      public static const const_617:int = 19;
      
      public static const const_898:int = 20;
      
      public static const const_1196:int = 22;
      
      public static const const_563:int = 23;
      
      public static const const_233:int = 24;
      
      public static const const_349:int = 25;
      
      public static const const_790:int = 26;
      
      public static const const_897:int = 27;
      
      public static const const_1222:int = 28;
      
      public static const const_965:int = 29;
      
      public static const const_677:int = 100;
      
      public static const const_482:int = 101;
      
      public static const const_155:int = 102;
      
      public static const const_489:int = 103;
      
      public static const const_1116:int = 104;
      
      public static const const_974:int = 105;
      
      public static const const_877:int = 106;
      
      public static const const_463:int = 107;
      
      public static const const_1205:int = 108;
      
      public static const const_743:int = 109;
      
      public static const const_361:int = 110;
      
      public static const const_408:int = 111;
      
      public static const const_133:int = 112;
      
      public static const const_904:int = 113;
      
      public static const const_310:int = 114;
      
      public static const const_523:int = 115;
      
      public static const const_1104:int = 116;
      
      public static const SOCKET_WRITE_EXCEPTION_1:int = 117;
      
      public static const SOCKET_WRITE_EXCEPTION_2:int = 118;
      
      public static const SOCKET_WRITE_EXCEPTION_3:int = 119;
      
      public static const const_835:int = 120;
      
      public static const const_320:int = 121;
      
      public static const const_776:int = 122;
      
      public static const const_447:int = 123;
      
      public static const const_655:int = 124;
      
      public static const const_138:int = 125;
      
      public static const const_770:int = 126;
      
      private static var var_3194:Dictionary;
      
      public function DisconnectReasonEvent(param1:Function)
      {
         super(param1,DisconnectReasonEventParser);
      }
      
      public static function resolveDisconnectedReasonLocalizationKey(param1:int) : String
      {
         switch(param1)
         {
            case -2:
               return "${disconnected.maintenance}";
            case 0:
               return "${disconnected.logged_out}";
            case 1:
               return "${disconnected.just_banned}";
            case 10:
               return "${disconnected.still_banned}";
            case 2:
            case 13:
            case 11:
            case 18:
               return "${disconnected.concurrent_login}";
            case 12:
            case 19:
               return "${disconnected.hotel_closed}";
            case 20:
               return "${disconnected.incorrect_password}";
            case 112:
               return "${disconnected.idle}";
            case 122:
               return "${disconnected.incompatible_client_version}";
            case 4:
            case 5:
            case 16:
            case 17:
            case 22:
            case 23:
            case 24:
            case 25:
            case 26:
            case 27:
            case 28:
            case 29:
            case 100:
            case 101:
            case 102:
            case 103:
            case 104:
            case 105:
            case 106:
            case 107:
            case 108:
            case 109:
            case 110:
            case 111:
            case 113:
            case 114:
            case 115:
            case 116:
            case 117:
            case 118:
            case 119:
            case 120:
            case 121:
            case 123:
            case 124:
            case 125:
            case 126:
               return "${disconnected.generic}";
            default:
               return "${disconnected.generic}";
         }
      }
      
      public function get reason() : int
      {
         return (this.var_15 as DisconnectReasonEventParser).reason;
      }
      
      public function get reasonString() : String
      {
         switch(reason)
         {
            case 1:
            case 10:
               return "banned";
            case 2:
               return "concurrentlogin";
            case 20:
               return "incorrectpassword";
            default:
               return "logout";
         }
      }
      
      public function getReasonName() : String
      {
         if(var_3194 == null)
         {
            var_3194 = new Dictionary();
            var _loc2_:XML = describeType(DisconnectReasonEvent);
            for each(var _loc1_ in null.constant)
            {
               var _loc3_:String = _loc1_.@name;
               var _loc4_:String = DisconnectReasonEvent[_loc1_.@name];
               var_3194[null] = null;
            }
         }
         return var_3194[reason];
      }
   }
}

