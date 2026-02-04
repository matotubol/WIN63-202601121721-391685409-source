package com.sulake.habbo.ui.widget.chooser.newfurni
{
   import com.sulake.core.assets.class_40;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.chooser.*;
   import com.sulake.habbo.ui.widget.events.RoomWidgetChooserContentEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
   import com.sulake.habbo.window.class_38;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   
   public class NewFurniChooserWidget extends ChooserWidgetBase
   {
      
      private var var_710:NewFurniView;
      
      private var _items:Array;
      
      private var var_2537:Dictionary;
      
      public function NewFurniChooserWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40 = null, param4:class_27 = null)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function dispose() : void
      {
         if(var_710 != null)
         {
            var_710.dispose();
            var_710 = null;
         }
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWCCE_FURNI_CHOOSER_CONTENT",onChooserContent);
         param1.addEventListener("RWCCE_FURNI_CHOOSER_CONTENT_ADD",onChooserContentAdded);
         param1.addEventListener("RWROUE_FURNI_REMOVED",onUpdateFurniChooser);
         param1.addEventListener("RWROUE_FURNI_ADDED",onUpdateFurniChooser);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWCCE_FURNI_CHOOSER_CONTENT",onChooserContent);
         param1.removeEventListener("RWCCE_FURNI_CHOOSER_CONTENT_ADD",onChooserContentAdded);
         param1.removeEventListener("RWROUE_FURNI_REMOVED",onUpdateFurniChooser);
         param1.removeEventListener("RWROUE_FURNI_ADDED",onUpdateFurniChooser);
      }
      
      private function onChooserContent(param1:RoomWidgetChooserContentEvent) : void
      {
         if(param1 == null || param1.items == null)
         {
            return;
         }
         if(var_710 == null)
         {
            var_710 = new NewFurniView(this,"${widget.chooser.furni.title}");
         }
         _items = [];
         var_2537 = new Dictionary();
         for each(var _loc2_ in param1.items)
         {
            if(_loc2_.id > 0)
            {
               _items.push(_loc2_);
               var_2537[_loc2_.id] = true;
            }
         }
         _items.sortOn(["lowerCaseName","id"],[null,16]);
         var_710.onItemsChanged();
      }
      
      private function onChooserContentAdded(param1:RoomWidgetChooserContentEvent) : void
      {
         if(param1 == null || param1.items == null || var_710 == null || _items == null)
         {
            return;
         }
         var _loc3_:Boolean = false;
         for each(var _loc2_ in param1.items)
         {
            if(_loc2_.id > 0 && !(_loc2_.id in var_2537))
            {
               _items.push(_loc2_);
               var_2537[_loc2_.id] = true;
               _loc3_ = true;
            }
         }
         if(_loc3_)
         {
            var_710.onItemsChanged();
         }
      }
      
      public function get items() : Array
      {
         return _items;
      }
      
      private function onUpdateFurniChooser(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:ChooserItem = null;
         if(var_710 == null || !var_710.isOpen())
         {
            return;
         }
         if(param1.type == "RWROUE_FURNI_REMOVED")
         {
            if(_items != null)
            {
               _loc3_ = 0;
               while(_loc3_ < _items.length)
               {
                  _loc2_ = _items[_loc3_];
                  if(_loc2_.id == param1.id && _loc2_.category == param1.category)
                  {
                     _items.removeAt(_loc3_);
                     delete var_2537[_loc2_.id];
                     var_710.onItemsChanged();
                     return;
                  }
                  _loc3_ += 1;
               }
            }
         }
         else if(param1.type == "RWROUE_FURNI_ADDED")
         {
            var _loc4_:RoomWidgetRequestWidgetMessage = new RoomWidgetRequestWidgetMessage("RWRWM_FURNI_CHOOSER_ADD",param1.id,param1.category);
            messageListener.processWidgetMessage(null);
         }
      }
   }
}

