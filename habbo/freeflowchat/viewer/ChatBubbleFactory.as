package com.sulake.habbo.freeflowchat.viewer
{
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.class_259;
   import com.sulake.habbo.avatar.pets.PetFigureData;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.data.ChatItem;
   import com.sulake.habbo.freeflowchat.history.visualization.entry.ChatHistoryEntryBitmapBubble;
   import com.sulake.habbo.freeflowchat.history.visualization.entry.ChatHistoryRoomChangeEntry;
   import com.sulake.habbo.freeflowchat.history.visualization.entry.class_2434;
   import com.sulake.habbo.freeflowchat.viewer.simulation.BlankStyle;
   import com.sulake.habbo.freeflowchat.viewer.visualization.ChatBubble;
   import com.sulake.habbo.freeflowchat.viewer.visualization.PooledChatBubble;
   import com.sulake.habbo.freeflowchat.viewer.visualization.style.ChatStyle;
   import com.sulake.habbo.freeflowchat.viewer.visualization.style.ChatStyleLibrary;
   import com.sulake.habbo.freeflowchat.viewer.visualization.style.class_2134;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.session.class_2146;
   import com.sulake.habbo.session.events.RoomSessionChatEvent;
   import com.sulake.habbo.utils.HabboFaceFocuser;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.utils.getTimer;
   import package_42.class_1945;
   
   public class ChatBubbleFactory implements class_1829, class_259
   {
      
      private static const MAX_DISPOSABLE_BITMAPS:int = 30;
      
      private var var_59:HabboFreeFlowChat;
      
      private var var_1571:ChatStyleLibrary;
      
      private var _avatarImageCache:class_55 = new class_55();
      
      private var _petImageCache:class_55 = new class_55();
      
      private var _avatarColorCache:class_55 = new class_55();
      
      private var _petImageIdToFigureString:class_55 = new class_55();
      
      private var var_1432:Array = [];
      
      private var var_1835:Vector.<PooledChatBubble> = new Vector.<PooledChatBubble>(0);
      
      private var var_2685:int;
      
      public function ChatBubbleFactory(param1:HabboFreeFlowChat)
      {
         super();
         var_59 = param1;
         var_1571 = new ChatStyleLibrary(var_59.assets);
         var_2685 = var_59.sessionDataManager.userId;
      }
      
      public function dispose() : void
      {
         discardOldBitmaps();
         var_1432 = [];
         var_1571.dispose();
         var_1571 = null;
         var_59 = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_59 == null;
      }
      
      public function getNewChatBubble(param1:ChatItem, param2:Boolean = false) : PooledChatBubble
      {
         var _loc11_:String = null;
         var _loc16_:IRoomObject = null;
         var _loc6_:String = null;
         var _loc20_:Boolean = false;
         var _loc9_:int = 0;
         var _loc21_:int = 0;
         var _loc10_:String = null;
         var _loc13_:String = null;
         var _loc8_:String = null;
         var _loc15_:String = null;
         var _loc7_:String = null;
         var _loc3_:String = null;
         var _loc17_:PooledChatBubble = null;
         var _loc19_:ChatStyle = ChatStyle(var_1571.getStyle(param1.style));
         var _loc4_:class_2146 = var_59.roomSessionManager.getSession(param1.roomId).userDataManager.getUserDataByIndex(param1.userId);
         var _loc12_:String = "";
         var _loc18_:uint = 0;
         var _loc5_:BitmapData = _loc19_.iconImage;
         if(param1.forcedFigure || param1.forcedUserName)
         {
            if(!_loc5_)
            {
               _loc5_ = getUserImage(param1.forcedFigure);
            }
            _loc12_ = param1.forcedUserName;
         }
         else if(_loc4_ != null)
         {
            _loc12_ = _loc4_.name;
            _loc11_ = _loc4_.figure;
            _loc18_ = _avatarColorCache.getValue(_loc11_);
            if(!_loc5_)
            {
               switch(_loc4_.type - 1)
               {
                  case 0:
                     _loc5_ = getUserImage(_loc11_);
                     break;
                  case 1:
                     _loc16_ = var_59.roomEngine.getRoomObject(param1.roomId,_loc4_.roomObjectId,100);
                     _loc6_ = null;
                     if(_loc16_ != null)
                     {
                        _loc6_ = _loc16_.getModel().getString("figure_posture");
                     }
                     _loc20_ = true;
                     _loc9_ = 32;
                     _loc21_ = 2;
                     _loc5_ = getPetImage(_loc11_,_loc21_,_loc20_,_loc9_,_loc6_);
               }
            }
         }
         if(param1.chatType == 3)
         {
            param1.text = !var_59.localizations ? "" : var_59.localizations.getLocalizationWithParams("widgets.chatbubble.respect","","username",_loc12_);
         }
         else if(param1.chatType == 4)
         {
            param1.text = !var_59.localizations ? "" : var_59.localizations.getLocalizationWithParams("widget.chatbubble.petrespect","","petname",_loc12_);
         }
         else if(param1.chatType == 6)
         {
            param1.text = !var_59.localizations ? "" : var_59.localizations.getLocalizationWithParams("widget.chatbubble.pettreat","","petname",_loc12_);
         }
         if(param1.chatType == 5)
         {
            _loc10_ = "widget.chatbubble.handitem";
            _loc13_ = var_59.localizations.getLocalization("handitem" + param1.extraParam,"handitem" + param1.extraParam);
            var_59.localizations.registerParameter(_loc10_,"username",_loc12_);
            var_59.localizations.registerParameter(_loc10_,"handitem",_loc13_);
            param1.text = var_59.localizations.getLocalizationRaw(_loc10_).value;
         }
         if(param1.chatType == 10)
         {
            _loc8_ = "widget.chatbubble.mutetime";
            _loc15_ = String(param1.extraParam % 60);
            _loc7_ = String(param1.extraParam > 0 ? Math.floor(param1.extraParam % 3600 / 60) : 0);
            _loc3_ = String(param1.extraParam > 0 ? Math.floor(param1.extraParam / 3600) : 0);
            var_59.localizations.registerParameter(_loc8_,"hours",_loc3_);
            var_59.localizations.registerParameter(_loc8_,"minutes",_loc7_);
            var_59.localizations.registerParameter(_loc8_,"seconds",_loc15_);
            param1.text = var_59.localizations.getLocalizationRaw(_loc8_).value;
         }
         if(var_1835.length > 0)
         {
            _loc17_ = var_1835.pop();
         }
         else
         {
            _loc17_ = new PooledChatBubble(var_59);
         }
         var _loc14_:Object = _loc19_.textFormat.color;
         _loc17_.chatItem = param1;
         _loc17_.style = _loc19_;
         _loc17_.face = _loc5_;
         _loc17_.recreate(_loc12_,param1.forcedColor ? param1.forcedColor : _loc18_,var_59.roomChatBorderLimited);
         _loc19_.textFormat.color = _loc14_;
         return _loc17_;
      }
      
      public function getNewEmptySpace(param1:int) : PooledChatBubble
      {
         var _loc4_:PooledChatBubble = null;
         var _loc5_:class_2134 = new BlankStyle();
         var _loc2_:RoomSessionChatEvent = new RoomSessionChatEvent("RSCE_CHAT_EVENT",null,-1,"",1);
         var _loc3_:ChatItem = new ChatItem(_loc2_,getTimer());
         if(var_1835.length > 0)
         {
            _loc4_ = var_1835.pop();
         }
         else
         {
            _loc4_ = new PooledChatBubble(var_59);
         }
         _loc4_.chatItem = _loc3_;
         _loc4_.style = _loc5_;
         _loc4_.face = null;
         _loc4_.recreate("",0,false,19);
         return _loc4_;
      }
      
      public function getHistoryLineEntry(param1:ChatItem) : class_2434
      {
         var _loc11_:String = null;
         var _loc15_:IRoomObject = null;
         var _loc6_:String = null;
         var _loc20_:Boolean = false;
         var _loc9_:int = 0;
         var _loc21_:int = 0;
         var _loc10_:String = null;
         var _loc13_:String = null;
         var _loc8_:String = null;
         var _loc14_:String = null;
         var _loc7_:String = null;
         var _loc2_:String = null;
         var _loc19_:ChatStyle = ChatStyle(var_1571.getStyle(param1.style));
         var _loc3_:class_2146 = var_59.roomSessionManager.getSession(param1.roomId).userDataManager.getUserDataByIndex(param1.userId);
         var _loc12_:String = "";
         var _loc18_:uint = 0;
         var _loc4_:BitmapData = _loc19_.iconImage;
         var _loc5_:* = !(_loc3_ == null || _loc3_.webID == var_2685);
         if(param1.forcedFigure || param1.forcedUserName)
         {
            if(!_loc4_)
            {
               _loc4_ = getUserImage(param1.forcedFigure);
            }
            _loc12_ = param1.forcedUserName;
         }
         else if(_loc3_ != null)
         {
            _loc12_ = _loc3_.name;
            _loc11_ = _loc3_.figure;
            _loc18_ = _avatarColorCache.getValue(_loc11_);
            if(!_loc4_)
            {
               switch(_loc3_.type - 1)
               {
                  case 0:
                  case 2:
                  case 3:
                     _loc4_ = getUserImage(_loc11_);
                     break;
                  case 1:
                     _loc15_ = var_59.roomEngine.getRoomObject(param1.roomId,_loc3_.roomObjectId,100);
                     _loc6_ = null;
                     if(_loc15_ != null)
                     {
                        _loc6_ = _loc15_.getModel().getString("figure_posture");
                     }
                     _loc20_ = false;
                     _loc9_ = 32;
                     _loc21_ = 2;
                     _loc4_ = getPetImage(_loc11_,_loc21_,_loc20_,_loc9_,_loc6_);
               }
            }
         }
         if(param1.chatType == 3)
         {
            param1.text = var_59.localizations ? "" : var_59.localizations.getLocalizationWithParams("widgets.chatbubble.respect","","username",_loc12_);
            _loc5_ = false;
         }
         else if(param1.chatType == 4)
         {
            param1.text = var_59.localizations ? "" : var_59.localizations.getLocalizationWithParams("widget.chatbubble.petrespect","","petname",_loc12_);
            _loc5_ = false;
         }
         else if(param1.chatType == 6)
         {
            param1.text = var_59.localizations ? "" : var_59.localizations.getLocalizationWithParams("widget.chatbubble.pettreat","","petname",_loc12_);
            _loc5_ = false;
         }
         if(param1.chatType == 5)
         {
            _loc10_ = "widget.chatbubble.handitem";
            _loc13_ = var_59.localizations.getLocalizationWithParams("handitem" + param1.extraParam,"handitem" + param1.extraParam);
            param1.text = var_59.localizations.getLocalizationWithParams(_loc10_,"","username",_loc12_,"handitem",_loc13_);
            _loc5_ = false;
         }
         if(param1.chatType == 10)
         {
            _loc8_ = "widget.chatbubble.mutetime";
            _loc14_ = String(param1.extraParam % 60);
            _loc7_ = String(param1.extraParam > 0 ? Math.floor(param1.extraParam % 3600 / 60) : 0);
            _loc2_ = String(param1.extraParam > 0 ? Math.floor(param1.extraParam / 3600) : 0);
            var_59.localizations.registerParameter(_loc8_,"hours",_loc2_);
            var_59.localizations.registerParameter(_loc8_,"minutes",_loc7_);
            var_59.localizations.registerParameter(_loc8_,"seconds",_loc14_);
            param1.text = var_59.localizations.getLocalizationRaw(_loc8_).value;
            _loc5_ = false;
         }
         var _loc16_:ChatBubble = new ChatBubble(param1,_loc19_,_loc4_,_loc12_,param1.forcedColor ? param1.forcedColor : _loc18_,var_59,1);
         var _loc17_:BitmapData = new BitmapData(_loc16_.width,_loc16_.height,true,0);
         _loc16_.drawToBitmap(_loc17_);
         return new ChatHistoryEntryBitmapBubble(param1,_loc5_,_loc12_,_loc17_,_loc19_.overlap);
      }
      
      public function getHistoryRoomChangeEntry(param1:class_1945) : class_2434
      {
         return new ChatHistoryRoomChangeEntry(param1,var_59);
      }
      
      public function recycle(param1:PooledChatBubble) : void
      {
         var_1835.push(param1);
      }
      
      public function getUserImage(param1:String) : BitmapData
      {
         var _loc3_:Boolean = var_59.getBoolean("zoom.enabled");
         var _loc2_:BitmapData = _avatarImageCache.getValue(param1) as BitmapData;
         if(_loc2_ == null)
         {
            var _loc5_:class_1827 = var_59.avatarRenderManager.createAvatarImage(param1,_loc3_ ? "h" : "sh",null,this);
            if(_loc5_ != null)
            {
               _loc2_ = HabboFaceFocuser.focusUserFace(null,"head",2,_loc3_ ? 0.5 : 1);
               var _loc4_:IPartColor = null.getPartColor("ch");
               null.dispose();
            }
         }
         if(_loc2_ != null)
         {
            _avatarImageCache.add(param1,_loc2_);
         }
         return _loc2_;
      }
      
      private function getPetImage(param1:String, param2:int, param3:Boolean, param4:int = 64, param5:String = null) : BitmapData
      {
         var _loc10_:BitmapData = _petImageCache.getValue(param1 + param5) as BitmapData;
         if(_loc10_ == null)
         {
            var _loc6_:PetFigureData = new PetFigureData(param1);
            var _loc8_:int = _loc6_.typeId;
            var _loc7_:uint = 0;
            var _loc11_:Boolean = false;
            var _loc9_:class_2198 = var_59.roomEngine.getPetImage(0,null.paletteId,null.color,new Vector3d(param2 * 45),param4,this,false,0,null.customParts,param5);
            if(_loc9_ != null)
            {
               _loc10_ = null.data;
               if(null.id > 0)
               {
                  _petImageIdToFigureString.add(null.id,null.figureString);
               }
            }
            _avatarColorCache.add(param1,null.color);
         }
         if(_loc10_ != null)
         {
            _petImageCache.add(param1 + param5,_loc10_);
         }
         return _loc10_;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         var _loc3_:String = _petImageIdToFigureString.remove(param1);
         if(_loc3_ != null)
         {
            petImageReady(_loc3_);
            if(_petImageCache)
            {
               _petImageCache.add(_loc3_,param2);
            }
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function petImageReady(param1:String) : void
      {
         if(_petImageCache)
         {
            var _loc2_:BitmapData = _petImageCache.remove(param1) as BitmapData;
         }
         if(var_1432.length > 30)
         {
            discardOldBitmaps();
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         if(_avatarImageCache)
         {
            var _loc2_:BitmapData = _avatarImageCache.remove(param1) as BitmapData;
         }
         if(var_1432.length > 30)
         {
            discardOldBitmaps();
         }
      }
      
      private function discardOldBitmaps() : void
      {
         for each(var _loc1_ in var_1432)
         {
            if(_loc1_ != null)
            {
               _loc1_.dispose();
            }
         }
      }
      
      public function get chatStyleLibrary() : ChatStyleLibrary
      {
         return var_1571;
      }
   }
}

