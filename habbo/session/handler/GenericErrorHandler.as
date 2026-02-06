package com.sulake.habbo.session.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.session.IRoomHandlerListener;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.events.RoomSessionErrorMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.GenericErrorEvent;
   import com.sulake.habbo.communication.messages.parser.handshake.GenericErrorEventParser;
   
   public class GenericErrorHandler extends BaseHandler
   {
      
      public function GenericErrorHandler(param1:IConnection, param2:IRoomHandlerListener)
      {
         super(param1,param2);
         if(param1 == null)
         {
            return;
         }
         param1.addMessageEvent(new GenericErrorEvent(onGenericError));
      }
      
      private function onGenericError(param1:IMessageEvent) : void
      {
         var _loc4_:String = null;
         var _loc2_:GenericErrorEventParser = (param1 as GenericErrorEvent).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IRoomSession = listener.getSession(var_56);
         if(_loc3_ == null)
         {
            return;
         }
         switch(_loc2_.errorCode - 4008)
         {
            case 0:
               _loc4_ = "RSEME_KICKED";
               if(listener && listener.events)
               {
                  listener.events.dispatchEvent(new RoomSessionErrorMessageEvent(_loc4_,_loc3_));
               }
               return;
            default:
               return;
         }
      }
   }
}

