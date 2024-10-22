// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import DropdownHoverController from "./dropdown_hover_controller"
application.register("dropdown-hover", DropdownHoverController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import NavbarController from "./navbar_controller"
application.register("navbar", NavbarController)

import PhoneNumberController from "./phone_number_controller"
application.register("phone-number", PhoneNumberController)

import PopperController from "./popper_controller"
application.register("popper", PopperController)

import PreviewsController from "./previews_controller"
application.register("previews", PreviewsController)

import SwiperController from "./swiper_controller"
application.register("swiper", SwiperController)

import TinymceController from "./tinymce_controller"
application.register("tinymce", TinymceController)


//// STIMULUS Components
//Password visibility component
import PasswordVisibility from '@stimulus-components/password-visibility'
application.register('password-visibility', PasswordVisibility)

// Dropdown Component
import Dropdown from '@stimulus-components/dropdown'
application.register('dropdown', Dropdown)

// Notification Component
import Notification from '@stimulus-components/notification'
application.register('notification', Notification)

//Modal Component
import Dialog from '@stimulus-components/dialog'
application.register('dialog', Dialog)

//Auto-submit component
import AutoSubmit from '@stimulus-components/auto-submit'
application.register('auto-submit', AutoSubmit)

//Popover component
import Popover from '@stimulus-components/popover'
application.register('popover', Popover)