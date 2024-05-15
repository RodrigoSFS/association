module PeopleHelper
  def status_icon(person)
      if person.active
        content_tag(:span, content_tag(:i, nil, class: "bi bi-check-circle"), class: 'text-success')
      else
        content_tag(:span, content_tag(:i, nil, class: "bi bi-x-circle"), class: 'text-danger')
      end
  end
end
