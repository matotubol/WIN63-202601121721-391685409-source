package com.sulake.habbo.ui.widget.poll
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPollMessage;
   
   public class PollOfferDialog implements class_3726
   {
      
      public static const OK:String = "POLL_OFFER_STATE_OK";
      
      public static const CANCEL:String = "POLL_OFFER_STATE_CANCEL";
      
      public static const UNKNOWN:String = "POLL_OFFER_STATE_UNKNOWN";
      
      private var _disposed:Boolean = false;
      
      private var _window:class_2250;
      
      private var var_61:String = "POLL_OFFER_STATE_UNKNOWN";
      
      private var var_16:PollWidget;
      
      private var var_197:int = -1;
      
      public function PollOfferDialog(param1:int, param2:String, param3:String, param4:PollWidget)
      {
         super();
         var_197 = param1;
         var_16 = param4;
         var _loc11_:XmlAsset = var_16.assets.getAssetByName("poll_offer") as XmlAsset;
         if(_loc11_ != null)
         {
            _window = var_16.windowManager.buildFromXML(_loc11_.content as XML) as class_2250;
            if(_window)
            {
               _window.center();
               var _loc9_:class_1741 = _window.findChildByName("poll_offer_button_ok");
               if(_loc9_ != null)
               {
                  null.addEventListener("WME_CLICK",onOk);
               }
               var _loc5_:class_1741 = _window.findChildByName("poll_offer_button_cancel");
               if(_loc5_ != null)
               {
                  null.addEventListener("WME_CLICK",onCancel);
               }
               var _loc7_:class_1741 = _window.findChildByName("poll_offer_button_later");
               if(_loc7_ != null)
               {
                  null.addEventListener("WME_CLICK",onLater);
               }
               var _loc6_:class_1741 = _window.findChildByName("header_button_close");
               if(_loc6_ != null)
               {
                  null.addEventListener("WME_CLICK",onClose);
               }
               var _loc12_:ITextWindow = _window.findChildByName("poll_offer_headline") as ITextWindow;
               if(_loc12_)
               {
                  null.htmlText = param2;
                  var _loc8_:IItemListWindow = _window.findChildByName("poll_offer_headline_wrapper") as IItemListWindow;
                  if(_loc8_)
                  {
                     _window.height += null.scrollableRegion.height - null.visibleRegion.height;
                  }
               }
               var _loc10_:ITextWindow = _window.findChildByName("poll_offer_summary") as ITextWindow;
               if(_loc10_)
               {
                  null.htmlText = param3;
                  _loc8_ = _window.findChildByName("poll_offer_summary_wrapper") as IItemListWindow;
                  if(_loc8_)
                  {
                     _window.height += null.scrollableRegion.height - null.visibleRegion.height;
                  }
               }
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get state() : String
      {
         return var_61;
      }
      
      public function start() : void
      {
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         var_16 = null;
      }
      
      private function onOk(param1:class_1758) : void
      {
         if(var_61 != "POLL_OFFER_STATE_UNKNOWN")
         {
            return;
         }
         var_61 = "POLL_OFFER_STATE_OK";
         var_16.messageListener.processWidgetMessage(new RoomWidgetPollMessage("RWPM_START",var_197));
      }
      
      private function onCancel(param1:class_1758) : void
      {
         if(var_61 != "POLL_OFFER_STATE_UNKNOWN")
         {
            return;
         }
         var_61 = "POLL_OFFER_STATE_CANCEL";
         var_16.messageListener.processWidgetMessage(new RoomWidgetPollMessage("RWPM_REJECT",var_197));
         var_16.pollCancelled(var_197);
      }
      
      private function onLater(param1:class_1758) : void
      {
         if(var_61 != "POLL_OFFER_STATE_UNKNOWN")
         {
            return;
         }
         var_61 = "POLL_OFFER_STATE_CANCEL";
         var_16.pollCancelled(var_197);
      }
      
      private function onClose(param1:class_1758) : void
      {
         if(var_61 != "POLL_OFFER_STATE_UNKNOWN")
         {
            return;
         }
         var_61 = "POLL_OFFER_STATE_CANCEL";
         var_16.messageListener.processWidgetMessage(new RoomWidgetPollMessage("RWPM_REJECT",var_197));
         var_16.pollCancelled(var_197);
      }
   }
}

