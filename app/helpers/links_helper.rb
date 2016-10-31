module LinksHelper
  def status(link)
    link.read == 'true' ? 'Unread' : 'Read'
  end
end
