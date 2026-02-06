package com.sulake.habbo.avatar
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.avatar.view.AvatarEditorNameChangeView;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectSelectedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectAddedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectExpiredMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectActivatedMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.avatar.CheckUserNameMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.avatar.SaveWardrobeOutfitMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.avatar.GetWardrobeMessageComposer;
   import com.sulake.habbo.communication.messages.parser.avatar.CheckUserNameResultMessageEventParser;
   import com.sulake.habbo.communication.messages.incoming.avatar.ChangeUserNameResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.avatar.WardrobeMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.avatar.CheckUserNameResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.action.AvatarEffectMessageEvent;
   
   public class AvatarEditorMessageHandler
   {
      
      private var _communication:class_57;
      
      private var var_55:HabboAvatarEditorManager;
      
      public function AvatarEditorMessageHandler(param1:HabboAvatarEditorManager, param2:class_57)
      {
         super();
         var_55 = param1;
         _communication = param2;
         _communication.addHabboConnectionMessageEvent(new AvatarEffectActivatedMessageEvent(onAvatarEffectActivated));
         _communication.addHabboConnectionMessageEvent(new AvatarEffectSelectedMessageEvent(onAvatarEffectSelected));
         _communication.addHabboConnectionMessageEvent(new WardrobeMessageEvent(onWardrobe));
         _communication.addHabboConnectionMessageEvent(new AvatarEffectAddedMessageEvent(onAvatarEffectAdded));
         _communication.addHabboConnectionMessageEvent(new AvatarEffectMessageEvent(onRoomAvatarEffects));
         _communication.addHabboConnectionMessageEvent(new UserRightsMessageEvent(onUserRights));
         _communication.addHabboConnectionMessageEvent(new AvatarEffectExpiredMessageEvent(onAvatarEffectExpired));
         _communication.addHabboConnectionMessageEvent(new CheckUserNameResultMessageEvent(onCheckUserNameResult));
      }
      
      public function dispose() : void
      {
         _communication = null;
         var_55 = null;
      }
      
      public function saveWardrobeOutfit(param1:int, param2:IOutfit) : void
      {
         if(_communication == null)
         {
            return;
         }
         var _loc3_:SaveWardrobeOutfitMessageComposer = new SaveWardrobeOutfitMessageComposer(param1,param2.figure,param2.gender);
         _communication.connection.send(_loc3_);
         _loc3_.dispose();
         _loc3_ = null;
      }
      
      public function checkName(param1:String) : void
      {
         if(_communication == null)
         {
            return;
         }
         _communication.connection.send(new CheckUserNameMessageComposer(param1));
      }
      
      private function onCheckUserNameResult(param1:CheckUserNameResultMessageEvent) : void
      {
         if(param1 == null || !var_55)
         {
            return;
         }
         var _loc3_:HabboAvatarEditor = var_55.getEditor(0);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:AvatarEditorNameChangeView = _loc3_.view.avatarEditorNameChangeView;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc4_:CheckUserNameResultMessageEventParser = param1.getParser();
         if(_loc4_.resultCode == ChangeUserNameResultMessageEvent.var_1851)
         {
            _loc2_.checkedName = _loc4_.name;
         }
         else
         {
            _loc2_.setNameNotAvailableView(_loc4_.resultCode,_loc4_.name,_loc4_.nameSuggestions);
         }
      }
      
      public function getWardrobe() : void
      {
         if(_communication == null)
         {
            return;
         }
         var _loc1_:GetWardrobeMessageComposer = new GetWardrobeMessageComposer();
         _communication.connection.send(_loc1_);
         _loc1_.dispose();
         _loc1_ = null;
      }
      
      private function onWardrobe(param1:WardrobeMessageEvent) : void
      {
         if(param1 == null || !var_55)
         {
            return;
         }
         var _loc2_:HabboAvatarEditor = var_55.getEditor(0);
         if(_loc2_)
         {
            _loc2_.wardrobe.updateSlots(param1.state,param1.outfits);
         }
      }
      
      private function onUserRights(param1:UserRightsMessageEvent) : void
      {
         if(param1 == null || !var_55)
         {
            return;
         }
         var _loc2_:HabboAvatarEditor = var_55.getEditor(0);
         if(_loc2_)
         {
            _loc2_.clubMemberLevel = param1.clubLevel != 0 ? 2 : 0;
            _loc2_.update();
         }
      }
      
      private function onAvatarEffectAdded(param1:IMessageEvent) : void
      {
         if(param1 == null || !var_55)
         {
            return;
         }
         var _loc2_:HabboAvatarEditor = var_55.getEditor(0);
         if(_loc2_)
         {
            _loc2_.effects.reset();
         }
      }
      
      private function onAvatarEffectActivated(param1:AvatarEffectActivatedMessageEvent) : void
      {
         if(param1 == null || !var_55)
         {
            return;
         }
         var _loc2_:HabboAvatarEditor = var_55.getEditor(0);
         if(_loc2_)
         {
            _loc2_.effects.reset();
            _loc2_.figureData.avatarEffectType = param1.getParser().type;
            _loc2_.figureData.updateView();
         }
      }
      
      private function onAvatarEffectExpired(param1:AvatarEffectExpiredMessageEvent) : void
      {
         var _loc3_:int = 0;
         if(param1 == null || !var_55)
         {
            return;
         }
         var _loc2_:HabboAvatarEditor = var_55.getEditor(0);
         if(_loc2_)
         {
            _loc2_.effects.reset();
            _loc3_ = param1.getParser().type;
            if(_loc2_.figureData.avatarEffectType == _loc3_)
            {
               _loc2_.figureData.avatarEffectType = -1;
               _loc2_.figureData.updateView();
            }
         }
      }
      
      private function onRoomAvatarEffects(param1:AvatarEffectMessageEvent) : void
      {
         if(param1 == null || !var_55)
         {
            return;
         }
         var _loc2_:HabboAvatarEditor = var_55.getEditor(0);
         if(_loc2_ && var_55.roomDesktop != null && param1.getParser().userId == var_55.roomDesktop.roomSession.ownUserRoomId)
         {
            _loc2_.figureData.avatarEffectType = param1.getParser().effectId;
            _loc2_.figureData.updateView();
         }
      }
      
      private function onAvatarEffectSelected(param1:AvatarEffectExpiredMessageEvent) : void
      {
         if(param1 == null || !var_55)
         {
            return;
         }
         var _loc2_:HabboAvatarEditor = var_55.getEditor(0);
         if(_loc2_)
         {
            _loc2_.figureData.avatarEffectType = param1.getParser().type;
            _loc2_.figureData.updateView();
         }
      }
   }
}

