package com.sulake.habbo.ui.widget.playlisteditor
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.sound.ISongInfo;
   import flash.geom.ColorTransform;
   
   public class PlayListEditorItemListView
   {
      
      private var var_1329:IItemListWindow;
      
      private var _items:Array;
      
      private var var_16:PlayListEditorWidget;
      
      private var var_165:PlayListEditorItem;
      
      private var var_1395:int = -1;
      
      private var var_2103:int = -1;
      
      public function PlayListEditorItemListView(param1:PlayListEditorWidget, param2:IItemListWindow)
      {
         super();
         var_1329 = param2;
         var_16 = param1;
         var_165 = null;
      }
      
      public function get selectedItemIndex() : int
      {
         return var_1395;
      }
      
      public function destroy() : void
      {
         if(var_1329 == null)
         {
            return;
         }
         var_1329.destroyListItems();
      }
      
      public function refresh(param1:Array, param2:int) : void
      {
         if(var_1329 == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         var_2103 = -1;
         _items = [];
         var_1329.destroyListItems();
         for each(var _loc6_ in param1)
         {
            var _loc3_:String = _loc6_.name;
            var _loc7_:String = _loc6_.creator;
            var _loc5_:ColorTransform = var_16.getDiskColorTransformFromSongData(_loc6_.songData);
            var _loc4_:PlayListEditorItem = new PlayListEditorItem(var_16,null,null,null);
            _loc4_.window.procedure = itemEventProc;
            null.removeButton.procedure = itemEventProc;
            var_1329.addListItem(null.window);
            _items.push(null);
         }
         setItemIndexPlaying(param2);
      }
      
      public function setItemIndexPlaying(param1:int) : void
      {
         var _loc2_:PlayListEditorItem = null;
         if(_items == null)
         {
            return;
         }
         if(param1 < 0)
         {
            for each(var _loc3_ in _items)
            {
               _loc3_.setIconState("PLEI_ICON_STATE_NORMAL");
            }
            return;
         }
         if(param1 >= _items.length)
         {
            return;
         }
         if(var_2103 >= 0 && var_2103 < _items.length)
         {
            _loc2_ = _items[var_2103] as PlayListEditorItem;
            _loc2_.setIconState("PLEI_ICON_STATE_NORMAL");
         }
         _loc2_ = _items[param1] as PlayListEditorItem;
         _loc2_.setIconState("PLEI_ICON_STATE_PLAYING");
         var_2103 = param1;
      }
      
      public function deselectAny() : void
      {
         if(var_165 != null)
         {
            var_165.deselect();
            var_165 = null;
            var_1395 = -1;
         }
      }
      
      private function itemEventProc(param1:class_1758, param2:class_1741) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = param1.type == "WME_DOUBLE_CLICK";
         if(param1.type == "WME_CLICK" || _loc3_)
         {
            if(param2.name == "button_remove_from_playlist" || _loc3_)
            {
               if(var_165 != null)
               {
                  var_165.deselect();
               }
               if(var_1395 > -1)
               {
                  var_16.sendRemoveFromPlayListMessage(var_1395);
               }
               var_165 = null;
               var_1395 = -1;
            }
            else
            {
               if(var_165 != null)
               {
                  var_165.deselect();
               }
               _loc4_ = var_1329.getListItemIndex(param1.window);
               if(_loc4_ != -1)
               {
                  var_1395 = _loc4_;
                  var_165 = _items[_loc4_];
                  var_165.select();
                  if(param2.name == "button_remove_from_playlist")
                  {
                     var_16.sendRemoveFromPlayListMessage(_loc4_);
                  }
                  if(var_16.mainWindowHandler != null)
                  {
                     var_16.mainWindowHandler.musicInventoryView.deselectAny();
                  }
               }
            }
         }
      }
   }
}

