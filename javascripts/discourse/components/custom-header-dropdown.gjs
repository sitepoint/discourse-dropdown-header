import Component from "@ember/component";
import { fn } from "@ember/helper";
import { on } from "@ember/modifier";
import { action } from "@ember/object";
import { service } from "@ember/service";
import DiscourseURL from "discourse/lib/url";
import CustomIcon from "./custom-icon";

export default class CustomHeaderDropdown extends Component {
  @service site;
  @service router;

  @action
  redirectToUrl(url, event) {
    if (this.site.mobileView) {
      this.toggleHeaderLinks();
    }

    const regex = new RegExp(`^${this.router.rootURL}`);
    if (regex.test(url)) {
      event.preventDefault();
      DiscourseURL.routeTo(url);
    }

    event.stopPropagation();
  }

  <template>
    <li
      class="custom-header-dropdown-link"
      title={{@item.title}}
      role="button"
      {{on "click" (fn this.redirectToUrl @item.url)}}
    >
      <CustomIcon @icon={{@item.icon}} />
      {{#if @item.url}}
        <a href={{@item.url}} class="custom-header-link-title">{{@item.title}}</a>
      {{else}}
        <span class="custom-header-link-title">{{@item.title}}</span>
      {{/if}}
      {{#if @item.description}}
        <span class="custom-header-link-desc">{{@item.description}}</span>
      {{/if}}
    </li>
  </template>
}
