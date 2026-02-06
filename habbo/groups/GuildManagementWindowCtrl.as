package com.sulake.habbo.groups
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.groups.badge.BadgeEditorCtrl;
   import com.sulake.habbo.groups.events.GuildSettingsChangedInManageEvent;
   import com.sulake.habbo.window.widgets.class_3087;
   import flash.display.BitmapData;
   import com.sulake.habbo.communication.messages.incoming.users.class_1818;
   import com.sulake.habbo.communication.messages.incoming.users.class_1819;
   import com.sulake.habbo.communication.messages.incoming.users.class_1843;
   import com.sulake.habbo.communication.messages.incoming.users.class_2794;
   import com.sulake.habbo.communication.messages.incoming.users.class_2927;
   import com.sulake.habbo.communication.messages.outgoing.users.CreateGuildMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.UpdateGuildBadgeMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.UpdateGuildSettingsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.UpdateGuildIdentityMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.UpdateGuildColorsMessageComposer;
   
   public class GuildManagementWindowCtrl implements class_13
   {
      
      private static const VIEW_IDENTITY:int = 1;
      
      private static const VIEW_BADGE:int = 2;
      
      private static const VIEW_COLORS:int = 3;
      
      private static const VIEW_CONFIRM:int = 4;
      
      private static const VIEW_SETTINGS:int = 5;
      
      private static const const_967:int = 43;
      
      private static const const_954:int = 69;
      
      private static const EDIT_HEADER_TEXTS_OFFSET:int = -20;
      
      private static const CREATE_HEADER_BITMAP_OFFSET:int = 36;
      
      private static const STEP_TITLE_Y_OFFSET_ACTIVE:int = 5;
      
      private static const STEP_TITLE_Y_OFFSET_INACTIVE:int = 9;
      
      private static const STEP_TITLE_CREDIT_Y_OFFSET_ACTIVE:int = 6;
      
      private static const STEP_TITLE_CREDIT_Y_OFFSET_INACTIVE:int = 10;
      
      private static const MAX_DESCRIPTION_LENGTH:int = 255;
      
      private static const MAX_NAME_LENGTH:int = 30;
      
      private var var_52:HabboGroupsManager;
      
      private var _window:class_1812;
      
      private var var_217:BadgeEditorCtrl;
      
      private var var_258:ColorGridCtrl;
      
      private var var_267:ColorGridCtrl;
      
      private var var_1386:class_2447;
      
      private var var_3346:Boolean = false;
      
      private var var_1481:int = 0;
      
      private var var_24:class_1818;
      
      private var var_96:int = 1;
      
      public function GuildManagementWindowCtrl(param1:HabboGroupsManager)
      {
         super();
         var_52 = param1;
         var_217 = new BadgeEditorCtrl(var_52);
         var_258 = new ColorGridCtrl(var_52,onPrimaryColorSelected);
         var_267 = new ColorGridCtrl(var_52,onSecondaryColorSelected);
         var_1386 = new class_2447();
      }
      
      public function dispose() : void
      {
         var_52 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_217)
         {
            var_217.dispose();
            var_217 = null;
         }
         if(var_258)
         {
            var_258.dispose();
            var_258 = null;
         }
         if(var_267)
         {
            var_267.dispose();
            var_267 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_52 == null;
      }
      
      private function prepare() : void
      {
         if(_window != null)
         {
            return;
         }
         _window = class_2250(var_52.getXmlWindow("group_management_window"));
         _window.findChildByTag("close").procedure = onCloseWindow;
         _window.center();
         _window.findChildByName("create_room_link_region").procedure = onCreateRoomLink;
         _window.findChildByName("cancel_link_region").procedure = onCancelLink;
         _window.findChildByName("next_step_button").procedure = onNextStep;
         _window.findChildByName("previous_step_link_region").procedure = onPreviousStep;
         _window.findChildByName("buy_button").procedure = onBuy;
         _window.findChildByName("vip_required_region").procedure = onGetVip;
         _window.addEventListener("WE_DEACTIVATED",onWindowUnActivated);
         _window.findChildByName("edit_tab_1").procedure = onTab;
         _window.findChildByName("edit_tab_2").procedure = onTab;
         _window.findChildByName("edit_tab_3").procedure = onTab;
         _window.findChildByName("edit_tab_5").procedure = onTab;
         _window.findChildByName("reset_badge").procedure = onBadgeReset;
         _window.findChildByName("reset_colors").procedure = onColorReset;
         _window.findChildByName("step_1_members_region").procedure = onMembersClick;
         var_1386.prepare(_window);
      }
      
      public function onFlatCreated(param1:int, param2:String) : void
      {
         if(_window != null && Boolean(_window.visible) && var_24 != null && !var_24.exists)
         {
            var_24.ownedRooms.splice(0,0,new class_2794(param1,param2,false));
            prepareRoomSelection();
            this.getBaseDropMenu().selection = 0;
         }
      }
      
      public function onSubscriptionChange() : void
      {
         if(_window != null && Boolean(_window.visible) && var_24 != null && !var_24.exists && var_96 == 4)
         {
            refresh();
         }
      }
      
      public function refresh() : void
      {
         var _loc2_:int = 0;
         var _loc1_:class_1741 = null;
         prepare();
         var _loc3_:Boolean = !var_24.exists || var_24.isOwner;
         _window.findChildByName("edit_tab_1").visible = _loc3_;
         _window.findChildByName("edit_tab_2").visible = _loc3_;
         _window.findChildByName("edit_tab_3").visible = _loc3_;
         _window.findChildByName("edit_tab_5").visible = _loc3_;
         _loc2_ = 1;
         while(_loc2_ <= 5)
         {
            getStepContainer(_loc2_).visible = var_96 == _loc2_;
            _loc1_ = _window.findChildByName("header_pic_bitmap_step_" + _loc2_);
            _loc1_.y = var_24.exists ? 0 : 36;
            _loc1_.visible = var_96 == _loc2_;
            _loc2_++;
         }
         _window.findChildByName("header_caption_txt").caption = getStepCaption();
         _window.findChildByName("header_desc_txt").caption = getStepDesc();
         _window.findChildByName("header_pic_bitmap");
         _window.findChildByName("header_caption_txt").y = 43 + getHeaderTextOffset();
         _window.findChildByName("header_desc_txt").y = 69 + getHeaderTextOffset();
         _window.findChildByName("edit_guild_tab_context").visible = var_24.exists;
         _window.findChildByName("footer_cont").visible = !var_24.exists;
         _window.findChildByName("reset_badge").visible = false;
         _window.findChildByName("reset_colors").visible = false;
         if(var_96 == 2)
         {
            if(!var_24.exists)
            {
               var_52.trackGoogle("groupPurchase","step2_badge");
            }
            if(!var_217.isIntialized)
            {
               var_217.createWindow(getStepContainer(2),var_24.badgeSettings);
               var_217.resetLayerOptions(var_24.badgeSettings);
            }
            _window.findChildByName("reset_badge").visible = var_24.exists;
         }
         if(var_96 == 3)
         {
            if(!var_24.exists)
            {
               var_52.trackGoogle("groupPurchase","step3_colors");
            }
            if(!var_258.isInitialized)
            {
               var_258.createAndAttach(getStepContainer(3),"guild_primary_color_selector",var_52.guildEditorData.guildPrimaryColors);
               if(var_24.exists)
               {
                  var_258.setSelectedColorById(var_24.primaryColorId);
               }
               else
               {
                  var_258.setSelectedColorById(var_52.guildEditorData.findMatchingPrimaryColorId(var_217.primaryColorIndex));
               }
            }
            if(!var_267.isInitialized)
            {
               var_267.createAndAttach(getStepContainer(3),"guild_secondary_color_selector",var_52.guildEditorData.guildSecondaryColors);
               if(var_24.exists)
               {
                  var_267.setSelectedColorById(var_24.secondaryColorId);
               }
               else
               {
                  var_267.setSelectedColorById(var_52.guildEditorData.findMatchingSecondaryColorId(var_217.secondaryColorIndex));
               }
            }
            _window.findChildByName("reset_colors").visible = var_24.exists;
         }
         if(var_96 == 5)
         {
            if(!var_1386.isInitialized)
            {
               var_1386.refresh(var_24);
            }
         }
         if(var_96 == 4)
         {
            if(!var_24.exists)
            {
               var_52.trackGoogle("groupPurchase","step4_confirm");
            }
            updateConfirmPreview();
         }
         if(var_96 == 1)
         {
            if(!var_24.exists)
            {
               var_52.trackGoogle("groupPurchase","step1_identity");
            }
            else
            {
               var_52.windowManager.registerLocalizationParameter("group.membercount","totalMembers","" + var_24.membershipCount);
               _window.findChildByName("step_1_members_txt").caption = var_52.localization.getLocalization("group.membercount");
            }
            _window.findChildByName("base_label").visible = !var_24.exists;
            _window.findChildByName("base_dropmenu").visible = !var_24.exists;
            _window.findChildByName("base_warning").visible = !var_24.exists;
            _window.findChildByName("create_room_link_region").visible = !var_24.exists;
            _window.findChildByName("step_1_members_region").visible = data.exists;
         }
         refreshCreateHeader();
      }
      
      private function updateConfirmPreview() : void
      {
         var _loc1_:BitmapData = null;
         var _loc5_:class_2251 = null;
         var _loc2_:class_2927 = null;
         var _loc4_:class_1741 = null;
         var _loc6_:class_2927 = null;
         var _loc3_:class_1741 = null;
         if(var_52.guildEditorData == null || _window == null)
         {
            return;
         }
         if(var_217.isIntialized)
         {
            _loc1_ = var_217.getBadgeBitmap();
            _loc5_ = _window.findChildByName("badge_preview_image") as class_2251;
            if(_loc1_ != null && _loc5_ != null)
            {
               _loc5_.bitmap = _loc1_;
            }
         }
         if(var_258.isInitialized)
         {
            _loc2_ = var_258.getSelectedColorData();
            _loc4_ = _window.findChildByName("badge_preview_primary_color_top");
            if(_loc2_ != null && _loc4_ != null)
            {
               _loc4_.color = _loc2_.color;
            }
         }
         if(var_267.isInitialized)
         {
            _loc6_ = var_267.getSelectedColorData();
            _loc3_ = _window.findChildByName("badge_preview_secondary_color_top");
            if(_loc6_ != null && _loc3_ != null)
            {
               _loc3_.color = _loc6_.color;
            }
         }
         if(var_52.hasVip)
         {
            _window.findChildByName("buy_button").enable();
            _window.findChildByName("buy_border").color = 16761600;
         }
         else
         {
            _window.findChildByName("buy_border").color = 11184810;
            _window.findChildByName("buy_button").disable();
         }
         _window.findChildByName("vip_required_border").visible = !var_52.hasVip;
         _window.findChildByName("confirmation_caption").caption = ITextWindow(_window.findChildByName("name_txt")).text;
      }
      
      private function getHeaderTextOffset() : int
      {
         return var_24.exists ? -20 : 0;
      }
      
      private function refreshCreateHeader() : void
      {
         var _loc1_:int = 0;
         _window.findChildByName("steps_header_cont").visible = !var_24.exists;
         if(var_24.exists)
         {
            return;
         }
         _window.findChildByName("next_step_button").visible = hasNextStep();
         _window.findChildByName("previous_step_link_region").visible = hasPreviousStep();
         _window.findChildByName("cancel_link_region").visible = !hasPreviousStep();
         _window.findChildByName("buy_border").visible = !hasNextStep();
         _loc1_ = 1;
         while(_loc1_ <= 4)
         {
            getStepHeader(_loc1_,false).visible = _loc1_ != var_96;
            getStepHeader(_loc1_,true).visible = _loc1_ == var_96;
            _window.findChildByName("step_title_" + _loc1_).y = _loc1_ == var_96 ? 5 : 9;
            _loc1_++;
         }
         _window.findChildByName("gcreate_icon_credit").y = var_96 == 4 ? 6 : 10;
      }
      
      private function getStepHeader(param1:int, param2:Boolean) : class_1741
      {
         return _window.findChildByName("gcreate_" + param1 + "_" + (param2 ? "1" : "0"));
      }
      
      private function getStepContainer(param1:int) : class_1812
      {
         return class_1812(_window.findChildByName("step_cont_" + param1));
      }
      
      private function getStepCaption() : String
      {
         var _loc1_:String = (var_24.exists ? "group.edit.tabcaption." : "group.create.stepcaption.") + var_96;
         return var_52.localization.getLocalization(_loc1_,_loc1_);
      }
      
      private function getStepDesc() : String
      {
         var _loc1_:String = (var_24.exists ? "group.edit.tabdesc." : "group.create.stepdesc.") + var_96;
         return var_52.localization.getLocalization(_loc1_,_loc1_);
      }
      
      public function onGuildCreationInfo(param1:class_1843) : void
      {
         var_24 = param1;
         var_96 = 1;
         var_1481 = 0;
         refresh();
         refreshBadgeImage();
         setupInputs();
         var_52.localization.registerParameter("group.create.confirm.buyinfo","amount","" + param1.costInCredits);
         _window.visible = true;
         _window.activate();
      }
      
      public function onGuildEditInfo(param1:class_1819) : void
      {
         var_24 = param1;
         var_96 = 1;
         var_1481 = 0;
         refresh();
         refreshBadgeImage();
         setupInputs();
         var _loc2_:ITabContextWindow = ITabContextWindow(_window.findChildByName("edit_guild_tab_context"));
         var _loc3_:ISelectableWindow = ISelectableWindow(_window.findChildByName("edit_tab_" + var_96));
         _loc2_.selector.setSelected(_loc3_);
         _window.visible = true;
         _window.activate();
      }
      
      private function setupInputs() : void
      {
         ITextWindow(_window.findChildByName("name_txt")).text = var_24.groupName;
         ITextWindow(_window.findChildByName("desc_txt")).text = var_24.groupDesc;
         prepareRoomSelection();
         var_217.resetLayerOptions(var_24.badgeSettings);
         var_258.setSelectedColorById(var_24.primaryColorId);
         var_267.setSelectedColorById(var_24.secondaryColorId);
         var_1386.refresh(var_24);
      }
      
      private function onTab(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WE_SELECT" || param2.id == var_96)
         {
            return;
         }
         if(!validateView())
         {
            param1.preventDefault();
            return;
         }
         saveView();
         var_96 = param2.id;
         refresh();
      }
      
      private function onColorReset(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            if(var_258.isInitialized)
            {
               var_258.setSelectedColorById(var_24.primaryColorId);
            }
            if(var_267.isInitialized)
            {
               var_267.setSelectedColorById(var_24.secondaryColorId);
            }
         }
      }
      
      private function onBadgeReset(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK" && var_217.isIntialized)
         {
            var_217.resetLayerOptions(var_24.badgeSettings);
         }
      }
      
      private function onMembersClick(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK" && var_24.exists && var_52.guildMembersWindowCtrl != null)
         {
            var_52.trackGoogle("groupManagement","groupMembers");
            var_52.guildMembersWindowCtrl.onMembersClick(var_24.groupId,0);
         }
      }
      
      private function onCancelLink(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         close();
      }
      
      private function onCreateRoomLink(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_52.navigator.startRoomCreation();
      }
      
      private function onNextStep(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(!validateView())
         {
            return;
         }
         var_96 = limitStep(var_96 + 1);
         refresh();
      }
      
      private function onPreviousStep(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(!validateView())
         {
            return;
         }
         var_96 = limitStep(var_96 - 1);
         refresh();
      }
      
      private function onBuy(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(!var_24.exists)
         {
            var_52.trackGoogle("groupPurchase","buyGroup");
         }
         sendCreateGuildMessage();
      }
      
      private function onGetVip(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(!var_24.exists)
         {
            var_52.trackGoogle("groupPurchase","buyVip");
         }
         var_52.openVipPurchase("GuildManagementWindowCtrl");
      }
      
      private function showAlert(param1:String, param2:String) : void
      {
         if(!var_3346)
         {
            var_3346 = true;
            var_52.windowManager.alert(param1,param2,0,onAlertClose);
         }
      }
      
      private function onAlertClose(param1:class_1750, param2:class_1758) : void
      {
         param1.dispose();
         var_3346 = false;
      }
      
      private function validateView() : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:class_2794 = null;
         var _loc4_:String = null;
         var _loc1_:Array = null;
         switch(var_96 - 1)
         {
            case 0:
               _loc2_ = ITextFieldWindow(_window.findChildByName("name_txt")).text;
               if(!var_24.exists)
               {
                  _loc3_ = resolveBaseRoom();
                  if(_loc2_ == null || _loc2_.length == 0 || _loc3_ == null || _loc3_.roomId == 0)
                  {
                     showAlert("${group.edit.error.title}","${group.edit.error.no.name.or.room.selected}");
                     return false;
                  }
                  if(_loc3_.hasControllers && var_1481 != _loc3_.roomId)
                  {
                     var_1481 = _loc3_.roomId;
                     showAlert("${group.edit.error.warning}","${group.edit.error.controllers}");
                     return false;
                  }
               }
               if(_loc2_.length > 30)
               {
                  showAlert("${group.edit.error.title}","${group.edit.error.name.length}");
                  return false;
               }
               _loc4_ = ITextFieldWindow(_window.findChildByName("desc_txt")).text;
               if(_loc4_ != null && _loc4_.length >= 255)
               {
                  showAlert("${group.edit.error.title}","${group.edit.error.desc.length}");
                  return false;
               }
               return true;
               break;
            case 1:
               _loc1_ = var_217.isIntialized ? var_217.getBadgeSettings() : var_24.badgeSettings;
               var_217.onViewChange();
               return true;
            case 2:
               if(var_258.getSelectedColorData() == null || var_267.getSelectedColorData() == null)
               {
                  showAlert("${group.edit.error.title}","${group.edit.error.no.color.selected}");
                  return false;
               }
               return true;
               break;
            default:
               return true;
         }
      }
      
      private function saveView() : void
      {
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         switch(var_96 - 1)
         {
            case 0:
               _loc3_ = ITextFieldWindow(_window.findChildByName("name_txt")).text;
               _loc5_ = ITextFieldWindow(_window.findChildByName("desc_txt")).text;
               if(var_24.isOwner)
               {
                  var_52.send(new UpdateGuildIdentityMessageComposer(var_24.groupId,_loc3_,_loc5_));
               }
               var_52.events.dispatchEvent(new GuildSettingsChangedInManageEvent("GSCIME_GUILD_VISUAL_SETTINGS_CHANGED",var_24.groupId));
               return;
            case 1:
               _loc1_ = var_217.isIntialized ? var_217.getBadgeSettings() : var_24.badgeSettings;
               if(var_24.isOwner)
               {
                  var_52.send(new UpdateGuildBadgeMessageComposer(var_24.groupId,_loc1_));
               }
               var_52.events.dispatchEvent(new GuildSettingsChangedInManageEvent("GSCIME_GUILD_VISUAL_SETTINGS_CHANGED",var_24.groupId));
               break;
            case 2:
               _loc2_ = var_258.isInitialized ? var_258.getSelectedColorId() : var_24.primaryColorId;
               _loc4_ = var_267.isInitialized ? var_267.getSelectedColorId() : var_24.secondaryColorId;
               if(var_24.isOwner)
               {
                  var_52.send(new UpdateGuildColorsMessageComposer(var_24.groupId,_loc2_,_loc4_));
               }
               var_52.events.dispatchEvent(new GuildSettingsChangedInManageEvent("GSCIME_GUILD_VISUAL_SETTINGS_CHANGED",var_24.groupId));
               break;
            case 4:
               if(var_24.isOwner)
               {
                  var_52.send(new UpdateGuildSettingsMessageComposer(var_24.groupId,var_1386.guildType,var_1386.rightsLevel));
               }
               var_1386.resetModified();
         }
      }
      
      private function sendCreateGuildMessage() : void
      {
         var _loc3_:String = ITextFieldWindow(_window.findChildByName("name_txt")).text;
         var _loc5_:String = ITextFieldWindow(_window.findChildByName("desc_txt")).text;
         var _loc6_:class_2794 = resolveBaseRoom();
         var _loc1_:Array = var_217.isIntialized ? var_217.getBadgeSettings() : var_24.badgeSettings;
         var _loc2_:int = var_258.isInitialized ? var_258.getSelectedColorId() : var_24.primaryColorId;
         var _loc4_:int = var_267.isInitialized ? var_267.getSelectedColorId() : var_24.secondaryColorId;
         var_1481 = 0;
         var_52.send(new CreateGuildMessageComposer(_loc3_,_loc5_,_loc6_.roomId,_loc2_,_loc4_,_loc1_));
      }
      
      private function hasPreviousStep() : Boolean
      {
         return var_96 != limitStep(var_96 - 1);
      }
      
      private function hasNextStep() : Boolean
      {
         return var_96 != limitStep(var_96 + 1);
      }
      
      private function limitStep(param1:int) : int
      {
         return Math.max(1,Math.min(param1,4));
      }
      
      private function getBaseDropMenu() : class_2261
      {
         return class_2261(_window.findChildByName("base_dropmenu"));
      }
      
      private function prepareRoomSelection() : void
      {
         var _loc2_:int = 0;
         var _loc4_:class_2794 = null;
         var _loc1_:class_2261 = getBaseDropMenu();
         var _loc3_:Array = [];
         var _loc5_:int = 0;
         _loc3_.push(var_52.localization.getLocalization("group.edit.base.select.room","group.edit.base.select.room"));
         _loc2_ = 0;
         while(_loc2_ < var_24.ownedRooms.length)
         {
            _loc4_ = var_24.ownedRooms[_loc2_];
            _loc3_.push(_loc4_.roomName);
            if(_loc4_.roomId == var_24.baseRoomId)
            {
               _loc5_ = _loc2_ + 1;
            }
            _loc2_++;
         }
         _loc1_.populate(_loc3_);
         if(_loc3_.length > 0)
         {
            _loc1_.selection = _loc5_;
         }
      }
      
      private function resolveBaseRoom() : class_2794
      {
         var _loc1_:class_2261 = class_2261(_window.findChildByName("base_dropmenu"));
         var _loc2_:int = _loc1_.selection - 1;
         if(_loc2_ >= 0 && _loc2_ < var_24.ownedRooms.length && var_24.ownedRooms[_loc2_] != null)
         {
            return class_2794(var_24.ownedRooms[_loc2_]);
         }
         return null;
      }
      
      private function onCloseWindow(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(var_24.exists)
         {
            if(!validateView())
            {
               return;
            }
            saveView();
         }
         close();
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            _window.visible = false;
         }
      }
      
      public function onPrimaryColorSelected(param1:ColorGridCtrl) : void
      {
         var _loc3_:class_2927 = null;
         var _loc2_:class_1741 = _window.findChildByName("guild_color_primary_color_top");
         if(_loc2_ != null && var_52.guildEditorData != null && param1.selectedColorIndex >= 0 && param1.selectedColorIndex <= var_52.guildEditorData.guildPrimaryColors.length)
         {
            _loc3_ = var_52.guildEditorData.guildPrimaryColors[param1.selectedColorIndex];
            _loc2_.color = _loc3_.color;
         }
      }
      
      public function onSecondaryColorSelected(param1:ColorGridCtrl) : void
      {
         var _loc3_:class_2927 = null;
         var _loc2_:class_1741 = _window.findChildByName("guild_color_secondary_color_top");
         if(var_52.guildEditorData != null && param1.selectedColorIndex >= 0 && param1.selectedColorIndex <= var_52.guildEditorData.guildSecondaryColors.length)
         {
            _loc3_ = var_52.guildEditorData.guildSecondaryColors[param1.selectedColorIndex];
            _loc2_.color = _loc3_.color;
         }
      }
      
      public function get data() : class_1818
      {
         return var_24;
      }
      
      private function refreshBadgeImage() : void
      {
         var _loc2_:class_1741 = _window.findChildByName("step_1_badge");
         var _loc1_:class_3087 = class_2010(_window.findChildByName("group_logo")).widget as class_3087;
         if(_loc1_ == null || _loc2_ == null)
         {
            return;
         }
         if(!var_24.exists)
         {
            _loc2_.visible = false;
            _loc2_.invalidate();
         }
         else
         {
            _loc1_.badgeId = var_24.badgeCode;
            _loc1_.groupId = var_24.groupId;
            _loc2_.visible = true;
            _loc2_.invalidate();
         }
      }
      
      private function onWindowUnActivated(param1:class_1758) : void
      {
         if(var_24 != null && var_24.exists && _window != null && Boolean(_window.visible))
         {
            saveView();
         }
      }
   }
}

